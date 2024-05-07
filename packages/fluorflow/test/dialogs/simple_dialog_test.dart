import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

final class _Dialog extends FluorFlowSimpleDialog {
  const _Dialog({required super.completer});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Dialog'),
              TextButton(
                onPressed: completer.confirm,
                child: const Text('confirm'),
              ),
              TextButton(
                onPressed: completer.cancel,
                child: const Text('cancel'),
              ),
              TextButton(
                onPressed: completer.abort,
                child: const Text('abort'),
              ),
            ],
          ),
        ],
      );
}

final class _TestView extends StatefulWidget {
  @override
  State<_TestView> createState() => _TestViewState();
}

class _TestViewState extends State<_TestView> {
  final _nav = const NavigationService();
  bool? _result;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextButton(
              onPressed: () async {
                final result = await _nav.showDialog<(bool?, dynamic)>(
                  dialogBuilder: NoTransitionPageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          _Dialog(completer: _nav.closeOverlay)),
                );
                setState(() => _result = result?.$1);
              },
              child: const Text('open')),
          Text(_result?.toString() ?? 'null'),
        ],
      );
}

void main() {
  group('FluorFlowSimpleDialog<TData>', () {
    testWidgets('should open via navigation service.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog'), findsOneWidget);
    });

    testWidgets('should confirm on close.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('confirm'));
      await tester.pumpAndSettle();

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('should cancel (not confirmed) on close.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('cancel'));
      await tester.pumpAndSettle();

      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('should return null on abort.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('abort'));
      await tester.pumpAndSettle();

      expect(find.text('null'), findsOneWidget);
    });

    testWidgets('should abort on barrier click.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(_TestView), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('null'), findsOneWidget);
    });
  });
}
