import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import '../../extensions/library.dart';
import '../base.dart';
import '../config.dart';

extension on ArgResults {
  bool get noTests => this['no-tests'];

  bool get stdout => this['stdout'];
}

class View extends BaseCommand {
  View() {
    argParser.addFlag('no-tests',
        defaultsTo: false,
        help: 'Do not generate tests for the view.',
        negatable: false);
    argParser.addFlag('stdout',
        help: 'Print the generated code to stdout instead of writing to file.',
        defaultsTo: false,
        negatable: false);
  }

  @override
  String get name => 'view';

  @override
  String get description => [
        'Generate a view with viewmodel (aliases: $aliases).',
        'The view is - depending on the configuration - generated',
        'in the presented directories (from the arguments)',
        'or if the arguments are omitted, the directories from',
        'the configuration is used.',
      ].join('\n');

  @override
  List<String> get aliases => ['v'];

  @override
  String get invocation =>
      '${super.invocation} name <view directory> <test directory>';

  @override
  Future run() async {
    final config = await FluorflowConfig.load();
    final (name, baseViewDirectory, testDirectory) = switch (args.rest) {
      [final name, ...] when args.stdout => (name, 'stdout', 'stdout'),
      [final name, final viewDirectory, final testDirectory] => (
          name,
          viewDirectory,
          testDirectory
        ),
      [final _, final _] when !args.noTests => throw UsageException(
          'If a view directory is provided, '
          'the test directory must be provided as well. '
          'Except when the --no-tests flag is set.',
          usage),
      [final name, final viewDirectory] when args.noTests => (
          name,
          viewDirectory,
          null
        ),
      [final name] => (name, config.viewDirectory, config.testViewDirectory),
      _ => throw UsageException(
          'At least the name of the view must be provided.', usage),
    };

    final baseName = name.replaceFirst(RegExp(r'[Vv]iew$'), '');
    final viewName = '${baseName}View'.pascalCase;
    final viewFile = '${viewName.snakeCase}.dart';
    final viewModelFile = '${baseName.toLowerCase()}_viewmodel.dart';
    final viewTestFile = p.setExtension(viewFile, '_test.dart');
    final viewModelTestFile = p.setExtension(viewModelFile, '_test.dart');

    await _output(p.join(baseViewDirectory, baseName.toLowerCase(), viewFile),
        _view(viewName, viewModelFile));
    await _output(
        p.join(baseViewDirectory, baseName.toLowerCase(), viewModelFile),
        _viewModel('${viewName}Model'));
    if (!args.noTests && testDirectory != null) {
      await _output(
          p.join(testDirectory, viewTestFile),
          _viewTest(viewName, config.packageName,
              p.join(baseViewDirectory, baseName.toLowerCase(), viewFile)));
      await _output(
          p.join(testDirectory, viewModelTestFile),
          _viewModelTest(
              '${viewName}Model',
              config.packageName,
              p.join(
                  baseViewDirectory, baseName.toLowerCase(), viewModelFile)));
    }
  }

  Future _output(String filename, Library content) async {
    if (args.stdout) {
      log(filename);
      log(content.toOutput());
    } else {
      log('Write $filename.');
      await File(filename)
          .create(recursive: true)
          .then((f) => f.writeAsString(content.toOutput()));
    }
  }

  Library _viewModel(String name) => Library((b) => b.body.add(Class((b) => b
    ..name = name
    ..modifier = ClassModifier.final$
    ..extend = refer('BaseViewModel', 'package:fluorflow/fluorflow.dart'))));

  Library _view(String name, String viewModelFile) =>
      Library((b) => b.body.add(Class((b) => b
        ..name = name
        ..modifier = ClassModifier.final$
        ..annotations
            .add(refer('Routable()', 'package:fluorflow/annotations.dart'))
        ..extend = TypeReference((b) => b
          ..symbol = 'FluorFlowView'
          ..url = 'package:fluorflow/fluorflow.dart'
          ..types.add(TypeReference((b) => b
            ..symbol = '${name}Model'
            ..url = viewModelFile)))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters.add(Parameter((b) => b
            ..name = 'key'
            ..named = true
            ..toSuper = true))))
        ..methods.add(Method((b) => b
          ..name = 'builder'
          ..annotations.add(refer('override'))
          ..returns = refer('Widget', 'package:flutter/widgets.dart')
          ..requiredParameters.add(Parameter((b) => b
            ..name = 'context'
            ..type = refer('BuildContext', 'package:flutter/widgets.dart')))
          ..requiredParameters.add(Parameter((b) => b
            ..name = 'viewModel'
            ..type = refer('${name}Model')))
          ..requiredParameters.add(Parameter((b) => b
            ..name = 'child'
            ..type = refer('Widget?', 'package:flutter/widgets.dart')))
          ..lambda = true
          ..body = refer('Placeholder', 'package:flutter/widgets.dart')
              .constInstance([]).code))
        ..methods.add(Method((b) => b
          ..name = 'viewModelBuilder'
          ..annotations.add(refer('override'))
          ..returns = refer('${name}Model', viewModelFile)
          ..requiredParameters.add(Parameter((b) => b
            ..name = 'context'
            ..type = refer('BuildContext', 'package:flutter/widgets.dart')))
          ..lambda = true
          ..body =
              refer('${name}Model', viewModelFile).newInstance([]).code)))));

  Library _viewTest(String name, String packageName, String viewFile) =>
      Library((b) => b
        ..body.add(Method((b) => b
          ..name = 'main'
          ..returns = refer('void')
          ..lambda = true
          ..body =
              refer('group', 'package:flutter_test/flutter_test.dart').call([
            literalString(name),
            Method((b) => b.body = Block.of([
                  refer('testWidgets', 'package:flutter_test/flutter_test.dart')
                      .call([
                    literalString('should render'),
                    Method((b) => b
                      ..requiredParameters
                          .add(Parameter((b) => b.name = 'tester'))
                      ..modifier = MethodModifier.async
                      ..body = Block.of([
                        refer('tester')
                            .property('pumpWidget')
                            .call([
                              refer(name,
                                      'package:$packageName/${viewFile.replaceFirst("lib/", "")}')
                                  .constInstance([])
                            ])
                            .awaited
                            .statement,
                        refer('expect').call([
                          refer('find').property('byType').call([
                            refer('Placeholder', 'package:flutter/widgets.dart')
                          ]),
                          refer('findsOneWidget')
                        ]).statement,
                      ])).closure,
                  ]).statement,
                ])).closure
          ]).code)));

  Library _viewModelTest(
          String name, String packageName, String viewModelFile) =>
      Library((b) => b
        ..body.add(Method((b) => b
          ..name = 'main'
          ..returns = refer('void')
          ..lambda = true
          ..body =
              refer('group', 'package:flutter_test/flutter_test.dart').call([
            literalString(name),
            Method((b) => b.body = Block.of([
                  refer('test', 'package:flutter_test/flutter_test.dart').call([
                    literalString('should instantiate'),
                    Method((b) => b
                      ..body = Block.of([
                        declareFinal('viewModel')
                            .assign(refer(name,
                                    'package:$packageName/${viewModelFile.replaceFirst("lib/", "")}')
                                .newInstance([]))
                            .statement,
                        refer('expect').call(
                            [refer('viewModel'), refer('isNotNull')]).statement,
                      ])).closure,
                  ]).statement,
                ])).closure
          ]).code)));
}
