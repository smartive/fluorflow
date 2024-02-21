import 'dart:async';

import 'package:analyzer/dart/element/type.dart' as analyzer;
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:fluorflow/annotations.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

extension on BuilderOptions {
  String get output => config['output'] ?? 'lib/app.bottom_sheets.dart';
}

class BottomSheetBuilder implements Builder {
  static final _allDartFilesInLib = Glob('{lib/*.dart,lib/**/*.dart}');

  final BuilderOptions options;

  const BottomSheetBuilder(this.options);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final output = AssetId(buildStep.inputId.package, options.output);
    final resolver = buildStep.resolver;
    final configChecker = TypeChecker.fromRuntime(BottomSheetConfig);
    const sheetSuperTypes = [
      'FluorFlowSimpleBottomSheet',
      'FluorFlowBottomSheet',
    ];

    var extension = Extension((b) => b
      ..name = 'BottomSheets'
      ..on = refer('BottomSheetService', 'package:fluorflow/fluorflow.dart'));

    await for (final assetId in buildStep.findAssets(_allDartFilesInLib)) {
      if (!await resolver.isLibrary(assetId)) {
        continue;
      }

      final lib = LibraryReader(await resolver.libraryFor(assetId));

      for (final (sheetClass, superType) in lib.classes
          .where((c) => c.allSupertypes
              .map((s) => s.element.name)
              .any((s) => sheetSuperTypes.contains(s)))
          .map((c) => (
                c,
                c.allSupertypes
                    .firstWhere((s) => sheetSuperTypes.contains(s.element.name))
              ))) {
        final configAnnotation =
            configChecker.hasAnnotationOf(sheetClass, throwOnUnresolved: false)
                ? ConstantReader(configChecker.firstAnnotationOf(sheetClass,
                    throwOnUnresolved: false))
                : null;

        final sheetReturnType = superType.typeArguments.first;
        final methodTupleRef = RecordType((b) => b
          ..isNullable = false
          ..positionalFieldTypes.add(refer('bool?'))
          ..positionalFieldTypes.add(recursiveTypeReference(
              lib, sheetReturnType,
              typeRefUpdates: (b) => b.isNullable = true)));
        final params = sheetClass.constructors.first.parameters
            .where(
                (p) => p.displayName != 'key' && p.displayName != 'completer')
            .toList(growable: false);

        extension = extension.rebuild((b) => b.methods.add(Method((b) => b
          ..name = 'show${sheetClass.displayName}'
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
            ..name = 'fullscreen'
            ..type = refer('bool')
            ..named = true
            ..defaultTo = literalBool(
                    configAnnotation?.read('defaultFullscreen').boolValue ??
                        false)
                .code))
          ..optionalParameters.add(Parameter((b) => b
            ..name = 'ignoreSafeArea'
            ..type = refer('bool')
            ..named = true
            ..defaultTo = literalBool(
                    configAnnotation?.read('defaultIgnoreSafeArea').boolValue ??
                        true)
                .code))
          ..optionalParameters.add(Parameter((b) => b
            ..name = 'draggable'
            ..type = refer('bool')
            ..named = true
            ..defaultTo = literalBool(
                    configAnnotation?.read('defaultDraggable').boolValue ??
                        true)
                .code))
          ..optionalParameters.addAll(params.map((p) => Parameter((b) => b
            ..name = p.name
            ..type = recursiveTypeReference(lib, p.type)
            ..required = p.isRequired
            ..defaultTo = p.hasDefaultValue ? Code(p.defaultValueCode!) : null
            ..named = true)))
          ..body = refer('showBottomSheet')
              .call([
                refer(sheetClass.displayName, assetId.uri.toString())
                    .newInstance(
                        params
                            .where((p) => p.isPositional)
                            .map((p) => refer(p.name)),
                        {
                      'completer': refer('closeSheet'),
                      for (final p in params.where((p) => p.isNamed))
                        p.name: refer(p.name)
                    }),
              ], {
                'barrierColor': refer('barrierColor'),
                'fullscreen': refer('fullscreen'),
                'draggable': refer('draggable'),
                'ignoreSafeArea': refer('ignoreSafeArea'),
              }, [
                methodTupleRef,
                refer(sheetClass.displayName, assetId.uri.toString()),
              ])
              .property('then')
              .call([
                Method((b) => b
                      ..requiredParameters.add(Parameter((b) => b.name = 'r'))
                      ..lambda = true
                      ..body = Code(
                          '(r?.\$1, ${sheetReturnType is analyzer.VoidType ? 'null' : r'r?.$2'})'))
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
