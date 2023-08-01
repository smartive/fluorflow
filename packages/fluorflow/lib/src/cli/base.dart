import 'package:args/args.dart';
import 'package:args/command_runner.dart';

abstract class BaseCommand extends Command {
  ArgResults get args => argResults!;

  // ignore: avoid_print
  void log(String msg) => print(msg);
}
