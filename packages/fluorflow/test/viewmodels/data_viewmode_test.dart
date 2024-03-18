import 'dart:async';

import 'package:fluorflow/src/viewmodels/data_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

final class _NormalViewModel extends DataViewModel<String> {
  _NormalViewModel() : super('Hello, World!');

  @override
  FutureOr<void> initialize() {
    data = 'Hello, brave new World!';
    return super.initialize();
  }
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
  });
}
