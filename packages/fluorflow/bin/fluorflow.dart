import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:fluorflow/src/cli/generate.dart';

const usageErrorExitCode = 64;

void main(List<String> args) {
  final runner = CommandRunner('fluorflow', 'CLI for the fluorflow framework.')
    ..addCommand(Generate());

  runner.run(args).catchError((error) {
    if (error is! UsageException) {
      throw error;
    }
    // ignore: avoid_print
    print(error);
    exit(usageErrorExitCode);
  });
}
