import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

class DialogElement {
  late final String stuff;
}

@DialogConfig(routeBuilder: RouteBuilder.fadeIn)
final class RedDialog extends FluorFlowSimpleDialog<void> {
  final List<DialogElement> elements;

  const RedDialog(this.elements, {super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.red[200],
        appBar: AppBar(
          title: const Text('Dialog'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Dialog Page'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: completer.confirm,
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
}
