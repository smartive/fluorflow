import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

class Foobar {}

final class ComplexReturnTypeSheet
    extends FluorFlowSimpleBottomSheet<(int, {Foobar f})> {
  const ComplexReturnTypeSheet({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => const Placeholder();
}
