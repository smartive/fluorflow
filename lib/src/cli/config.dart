import 'dart:io';

import 'package:yaml/yaml.dart';

const _configFileName = 'pubspec.yaml';

final class FluorflowConfig {
  final dynamic _config;
  final dynamic _pubspec;

  FluorflowConfig._(this._pubspec) : _config = _pubspec?['fluorflow'];

  String get packageName => _pubspec?['name'] ?? 'unknown';

  String get viewDirectory => _config?['view_directory'] ?? 'lib/ui/views';

  String get testViewDirectory =>
      _config?['test_view_directory'] ?? 'test/ui/views';

  static Future<FluorflowConfig> load() async {
    final pubspec = loadYaml(await File(_configFileName).readAsString());
    return FluorflowConfig._(pubspec);
  }
}
