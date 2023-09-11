import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

extension Utilities on Library {
  String toOutput() => DartFormatter().format(accept(DartEmitter(
          allocator: Allocator(),
          useNullSafetySyntax: true,
          orderDirectives: true))
      .toString());
}
