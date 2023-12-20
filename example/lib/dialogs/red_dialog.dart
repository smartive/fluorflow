import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

@DialogConfig(routeBuilder: RouteBuilder.fadeIn)
final class RedDialog extends FluorFlowSimpleDialog<void> {
  const RedDialog({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.indigo,
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
