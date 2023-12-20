import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

final class GreetingBottomSheet extends FluorFlowSimpleBottomSheet<void> {
  const GreetingBottomSheet({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber[200],
        appBar: AppBar(
          title: const Text('Bottom Sheet'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('A Bottom Sheet'),
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
