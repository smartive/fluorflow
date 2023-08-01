import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

typedef FancyCallback = void Function();

class BottomSheetElement {
  late final String stuff;
}

final class GreetingBottomSheet extends FluorFlowSimpleBottomSheet<void> {
  final FancyCallback callback;
  final void Function(BottomSheetElement element) onElement;

  const GreetingBottomSheet(this.callback, this.onElement,
      {super.key, required super.completer});

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
