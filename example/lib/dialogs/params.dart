import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

final class ParamDialog extends FluorFlowSimpleDialog<String> {
  final String name;

  const ParamDialog(this.name, {super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Text('param dialog $name'),
              TextButton(
                  onPressed: () => completer.confirm(name),
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
