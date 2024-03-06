import 'dart:async';

import 'package:analyzer/dart/element/type.dart' as analyzer;
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:fluorflow/annotations.dart';
import 'package:glob/glob.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

extension on BuilderOptions {
  String get output => config['output'] ?? 'lib/app.dialogs.dart';
}

class DialogBuilder implements Builder {
  static final _allDartFilesInLib = Glob('{lib/*.dart,lib/**/*.dart}');

  final BuilderOptions options;

  const DialogBuilder(this.options);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final output = AssetId(buildStep.inputId.package, options.output);
    final resolver = buildStep.resolver;
    final configChecker = TypeChecker.fromRuntime(DialogConfig);
    const dialogSuperTypes = [
      'FluorFlowSimpleDialog',
      'FluorFlowDialog',
    ];

    var extension = Extension((b) => b
      ..name = 'Dialogs'
      ..on = refer('DialogService', 'package:fluorflow/fluorflow.dart'));

    await for (final assetId in buildStep.findAssets(_allDartFilesInLib)) {
      if (!await resolver.isLibrary(assetId)) {
        continue;
      }

      final lib = LibraryReader(await resolver.libraryFor(assetId));

      for (final (dialogClass, superType) in lib.classes
          .where((c) => c.allSupertypes
              .map((s) => s.element.name)
              .any((s) => dialogSuperTypes.contains(s)))
          .map((c) => (
                c,
                c.allSupertypes.firstWhere(
                    (s) => dialogSuperTypes.contains(s.element.name))
              ))) {
        final configAnnotation =
            configChecker.hasAnnotationOf(dialogClass, throwOnUnresolved: false)
                ? ConstantReader(configChecker.firstAnnotationOf(dialogClass,
                    throwOnUnresolved: false))
                : null;

        final dialogReturnType = superType.typeArguments.first;
        final methodTupleRef = RecordType((b) => b
          ..isNullable = false
          ..positionalFieldTypes.add(refer('bool?'))
          ..positionalFieldTypes.add(recursiveTypeReference(
              lib, dialogReturnType,
              forceNullable: true)));
        final params = dialogClass.constructors.first.parameters
            .where(
                (p) => p.displayName != 'key' && p.displayName != 'completer')
            .toList(growable: false);
        final dialogBuilder = configAnnotation == null
            ? refer('NoTransitionPageRouteBuilder',
                'package:fluorflow/fluorflow.dart')
            : switch ((
                getEnumFromAnnotation(
                    RouteBuilder.values,
                    configAnnotation.read('routeBuilder').objectValue,
                    RouteBuilder.noTransition),
                configAnnotation.read('pageRouteBuilder').isNull
              )) {
                (RouteBuilder.custom, true) => throw InvalidGenerationSourceError(
                    'You must provide a pageRouteBuilder when using a custom routeBuilder.',
                    element: dialogClass),
                (RouteBuilder.custom, false) => refer(
                    configAnnotation
                        .read('pageRouteBuilder')
                        .typeValue
                        .getDisplayString(withNullability: false),
                    lib
                        .pathToElement(configAnnotation
                            .read('pageRouteBuilder')
                            .typeValue
                            .element!)
                        .toString()),
                (final t, _) => refer('${t.name.pascalCase}PageRouteBuilder',
                    'package:fluorflow/fluorflow.dart'),
              };

        extension = extension.rebuild((b) => b.methods.add(Method((b) => b
          ..name = 'show${dialogClass.displayName}'
          ..returns = TypeReference((b) => b
            ..symbol = 'Future'
            ..types.add(methodTupleRef))
          ..lambda = true
          ..optionalParameters.add(Parameter((b) => b
            ..name = 'barrierColor'
            ..type = refer('Color', 'dart:ui')
            ..named = true
            ..defaultTo = refer('Color', 'dart:ui').constInstance([
              CodeExpression(Code(
                  '0x${(configAnnotation?.read('defaultBarrierColor').intValue ?? 0x80000000).toRadixString(16).padLeft(8, '0')}'))
            ]).code))
          ..optionalParameters.add(Parameter((b) => b
            ..name = 'barrierDismissible'
            ..type = refer('bool')
            ..named = true
            ..defaultTo = literalBool(configAnnotation
                        ?.read('defaultBarrierDismissible')
                        .boolValue ??
                    false)
                .code))
          ..optionalParameters.addAll(params.map((p) => Parameter((b) => b
            ..name = p.name
            ..type = recursiveTypeReference(lib, p.type)
            ..required = p.isRequired
            ..defaultTo = p.hasDefaultValue ? Code(p.defaultValueCode!) : null
            ..named = true)))
          ..body = refer('showDialog')
              .call([], {
                'barrierColor': refer('barrierColor'),
                'barrierDismissible': refer('barrierDismissible'),
                'dialogBuilder': dialogBuilder.newInstance([], {
                  'pageBuilder': Method((b) => b
                    ..requiredParameters.add(Parameter((b) => b.name = '_'))
                    ..requiredParameters.add(Parameter((b) => b.name = '__'))
                    ..requiredParameters.add(Parameter((b) => b.name = '___'))
                    ..lambda = true
                    ..body =
                        refer(dialogClass.displayName, assetId.uri.toString())
                            .newInstance(
                                params
                                    .where((p) => p.isPositional)
                                    .map((p) => refer(p.name)),
                                {
                          'completer': refer('closeDialog'),
                          for (final p in params.where((p) => p.isNamed))
                            p.name: refer(p.name)
                        }).code).closure
                })
              }, [
                methodTupleRef
              ])
              .property('then')
              .call([
                Method((b) => b
                      ..requiredParameters.add(Parameter((b) => b.name = 'r'))
                      ..lambda = true
                      ..body = Code(
                          '(r?.\$1, ${dialogReturnType is analyzer.VoidType ? 'null' : r'r?.$2'})'))
                    .closure
              ])
              .code)));
      }
    }

    if (extension.methods.isEmpty) {
      return;
    }

    final outputLib = Library((b) => b
      ..ignoreForFile.add('type=lint')
      ..body.add(extension));

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
}
