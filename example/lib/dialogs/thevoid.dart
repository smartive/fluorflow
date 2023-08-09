import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

final class VoidDialog extends FluorFlowSimpleDialog<void> {
  const VoidDialog({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const Text('void dialog'),
              TextButton(
                  onPressed: () => completer.confirm(),
                  child: const Text('Confirm')),
              TextButton(
                  onPressed: () => completer.cancel(),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => completer.abort(),
                  child: const Text('Abort')),
            ],
          ),
        ),
      );
}
