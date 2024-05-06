import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:fluorflow/annotations.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

extension on BuilderOptions {
  String get output => config['output'] ?? 'test/test.locator.dart';

  Map<String, dynamic> get services => config['services'] ?? {};

  bool get mockNavService => services['navigation'] ?? true;
}

class TestLocatorBuilder implements Builder {
  static final _allDartFilesInLib =
      Glob('{lib/*.dart,lib/**/*.dart,test/*.dart,test/**/*.dart}');
  static final _ignoreAnnotation = TypeChecker.fromRuntime(IgnoreDependency);
  static final _customLocatorAnnotation =
      TypeChecker.fromRuntime(CustomLocatorFunction);
  static final _isFactory = TypeChecker.fromRuntime(Factory);
  static final _nonFactory = TypeChecker.any([
    TypeChecker.fromRuntime(Singleton),
    TypeChecker.fromRuntime(AsyncSingleton),
    TypeChecker.fromRuntime(LazySingleton),
  ]);

  final BuilderOptions options;

  const TestLocatorBuilder(this.options);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final packageConfig = await buildStep.packageConfig;
    if (!packageConfig.packages.any((p) => p.name == 'mockito')) {
      // do not run the builder when mockito is not installed.
      log.info('Mockito is not installed, skipping builder.');
      return;
    }

    final output = AssetId(buildStep.inputId.package, options.output);
    final resolver = buildStep.resolver;
    final locatorRef = refer('locator', 'package:fluorflow/fluorflow.dart');
    final mocksUri = '${p.basenameWithoutExtension(options.output)}.mocks.dart';

    var outputLib = Library((b) => b..ignoreForFile.add('type=lint'));
    var setupTestLocatorMethodBody = Block();
    var setupTestLocatorMethod = Method((b) => b
      ..name = 'setupTestLocator'
      ..returns = refer('void'));

    final mockedTypes = List<Reference>.empty(growable: true);

    void addNonFactoryMock(Reference originalType, Reference mockType) {
      outputLib = outputLib.rebuild((b) => b.body.add(Method((b) => b
        ..name = 'get${mockType.symbol}'
        ..returns = mockType
        ..body = Block.of([
          Code.scope(
              (a) => 'if (${a(locatorRef)}.isRegistered<${a(originalType)}>())'
                  '{${a(locatorRef)}.unregister<${a(originalType)}>();}'),
          declareFinal('service').assign(mockType.newInstance([])).statement,
          locatorRef
              .property('registerSingleton')
              .call([refer('service')], {}, [originalType]).statement,
          refer('service').returned.statement,
        ]))));
    }

    void addInternalType(Reference internalType) {
      final mockType = refer('Mock${internalType.symbol}', mocksUri);
      mockedTypes.add(internalType);
      addNonFactoryMock(internalType, mockType);
      setupTestLocatorMethodBody = setupTestLocatorMethodBody.rebuild(
          (b) => b.addExpression(refer('get${mockType.symbol}').call([])));
    }

    await for (final assetId in buildStep.findAssets(_allDartFilesInLib)) {
      if (!await resolver.isLibrary(assetId)) {
        continue;
      }

      final lib = LibraryReader(await resolver.libraryFor(assetId));

      for (final AnnotatedElement(:annotation, :element) in lib
          .annotatedWith(TypeChecker.any([
            _nonFactory,
            _isFactory,
          ]))
          .where((element) => !_hasIgnoreAnnotation(element))) {
        // For all annotations (except Factory), the mocked element is either
        // the annotated class or the returnvalue of the factory function.
        // For all factories (Factory annotations), the mocked element is the
        // return value regardless of params. But the factory is still registered.
        final originalType = switch (element) {
          final ClassElement e =>
            refer(e.displayName, lib.pathToElement(e).toString()),
          FunctionElement(returnType: final InterfaceType rt)
              when (rt.isDartAsyncFuture || rt.isDartAsyncFutureOr) =>
            refer(
                rt.typeArguments.first.getDisplayString(withNullability: true),
                lib.pathToElement(rt.typeArguments.first.element!).toString()),
          FunctionElement(:final returnType) => refer(
              returnType.getDisplayString(withNullability: true),
              lib.pathToElement(returnType.element!).toString()),
          _ => throw InvalidGenerationSourceError('Invalid element type.',
              element: element),
        };
        final mockType = refer('Mock${originalType.symbol}', mocksUri);
        mockedTypes.add(originalType);

        if (annotation.instanceOf(_nonFactory)) {
          addNonFactoryMock(originalType, mockType);
        } else {
          outputLib = outputLib.rebuild((b) => b.body.add(Method((b) => b
            ..name = 'get${mockType.symbol}'
            ..returns = mockType
            ..body = Block.of([
              Code.scope((a) =>
                  'if (${a(locatorRef)}.isRegistered<${a(originalType)}>())'
                  '{${a(locatorRef)}.unregister<${a(originalType)}>();}'),
              declareFinal('service')
                  .assign(mockType.newInstance([]))
                  .statement,
              locatorRef.property('registerFactory').call(
                  [Method((b) => b.body = refer('service').code).closure],
                  {},
                  [originalType]).statement,
              refer('service').returned.statement,
            ]))));
        }

        setupTestLocatorMethodBody = setupTestLocatorMethodBody.rebuild(
            (b) => b.addExpression(refer('get${mockType.symbol}').call([])));
      }

      for (final AnnotatedElement(:element) in lib
          .annotatedWith(_customLocatorAnnotation)
          .where((element) => element.element is FunctionElement)
          .where((element) =>
              element.annotation.read('includeInTestLocator').boolValue)) {
        setupTestLocatorMethodBody = setupTestLocatorMethodBody.rebuild((b) =>
            b.addExpression(refer(
                    element.displayName, lib.pathToElement(element).toString())
                .call([])));
      }
    }

    if (options.mockNavService) {
      addInternalType(
          refer('NavigationService', 'package:fluorflow/fluorflow.dart'));
    }

    setupTestLocatorMethod = setupTestLocatorMethod.rebuild((b) => b
      ..body = setupTestLocatorMethodBody
      ..annotations.add(
          refer('GenerateNiceMocks', 'package:mockito/annotations.dart').call([
        literalList(mockedTypes.map((t) =>
            refer('MockSpec', 'package:mockito/annotations.dart')
                .newInstance([], {
              'onMissingStub':
                  refer('OnMissingStub', 'package:mockito/annotations.dart')
                      .property('returnDefault')
            }, [
              t
            ])))
      ])));
    outputLib = outputLib.rebuild((b) => b
      ..body.add(setupTestLocatorMethod)
      ..body.add(Method((b) => b
        ..name = 'tearDownLocator'
        ..returns = refer('void')
        ..lambda = true
        ..body = locatorRef.property('reset').call([]).code)));

    buildStep.writeAsString(
        output,
        DartFormatter().format(outputLib
            .accept(DartEmitter.scoped(
                useNullSafetySyntax: true, orderDirectives: true))
            .toString()));
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'lib/$lib$': [options.output],
      };

  bool _hasIgnoreAnnotation(AnnotatedElement e) =>
      ConstantReader(_ignoreAnnotation.firstAnnotationOf(e.element,
              throwOnUnresolved: false))
          .peek('inTestLocator')
          ?.boolValue ==
      true;
}
