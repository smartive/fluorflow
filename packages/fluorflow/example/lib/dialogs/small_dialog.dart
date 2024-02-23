import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

@DialogConfig(
    routeBuilder: RouteBuilder.topToBottomFade, defaultBarrierDismissible: true)
final class SmallDialog extends FluorFlowSimpleDialog<void> {
  const SmallDialog({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Dialog Page'),
                const Text('Close via button or click into background'),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: completer.confirm,
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      );
}
