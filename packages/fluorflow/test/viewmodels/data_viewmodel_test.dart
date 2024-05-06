import 'dart:async';

import 'package:fluorflow/src/viewmodels/data_viewmodel.dart';
import 'package:fluorflow/src/views/fluorflow_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

final class _NormalViewModel extends DataViewModel<String> {
  _NormalViewModel() : super('Hello, World!');

  @override
  FutureOr<void> initialize() {
    data = 'Hello, brave new World!';
    return super.initialize();
  }

  void updateData() => data = 'Updated!';
}

final class _ErrorViewModel extends DataViewModel<String> {
  _ErrorViewModel() : super('Hello, World!');

  @override
  FutureOr<void> initialize() async {
    try {
      throw StateError('Error');
    } catch (e) {
      error = e;
    } finally {
      await super.initialize();
    }
  }
}

final class _TestView extends FluorFlowView<_NormalViewModel> {
  @override
  Widget builder(
          BuildContext context, _NormalViewModel viewModel, Widget? child) =>
      Column(
        children: [
          Text(viewModel.data),
          TextButton(
              onPressed: viewModel.updateData, child: const Text('update')),
        ],
      );

  @override
  _NormalViewModel viewModelBuilder(BuildContext context) => _NormalViewModel();
}

void main() {
  group('DataViewModel<TData>', () {
    test('should set the provided initial data.', () async {
      final viewModel = _NormalViewModel();
      expect(viewModel.data, 'Hello, World!');
    });

    test('should set the provided data of when initialized.', () async {
      final viewModel = _NormalViewModel();
      await viewModel.initialize();
      expect(viewModel.data, 'Hello, brave new World!');
    });

    test('should set initialized.', () async {
      final viewModel = _NormalViewModel();
      expect(viewModel.initialized, false);
      await viewModel.initialize();
      expect(viewModel.initialized, true);
    });

    test('should set initialized on error (when coded).', () async {
      final viewModel = _ErrorViewModel();
      expect(viewModel.initialized, false);
      await viewModel.initialize();
      expect(viewModel.initialized, true);
    });

    test('should attach listener on error.', () async {
      final viewModel = _ErrorViewModel();
      await viewModel.initialize();
      // ignore: invalid_use_of_protected_member
      expect(viewModel.dataNotifier.hasListeners, true);
    });

    test('should set error state when initialize data fails.', () async {
      final viewModel = _ErrorViewModel();
      await viewModel.initialize();
      expect(viewModel.error, isA<StateError>());
    });

    testWidgets('should show initial data on view.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      expect(find.text('Hello, brave new World!'), findsOneWidget);
    });

    testWidgets('should update ui after data change.', (tester) async {
      await tester.pumpWidget(mockApp(_TestView()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('update'));

      await tester.pumpAndSettle();

      expect(find.text('Updated!'), findsOneWidget);
    });
  });
}
