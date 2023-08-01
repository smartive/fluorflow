import 'base.dart';
import 'generate/view.dart';

class Generate extends BaseCommand {
  @override
  String get name => 'generate';

  @override
  String get description =>
      'Generate code files for your project (aliases: $aliases).';

  @override
  List<String> get aliases => ['g', 'gen'];

  Generate() {
    addSubcommand(View());
  }
}
