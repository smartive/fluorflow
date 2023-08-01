import 'dart:async';

import 'package:flutter/foundation.dart';

import 'viewmodel.dart';

/// Base viewmodel that implements [ViewModel] and [ChangeNotifier].
/// Provides basic functionality for other view models and for the usage with views.
///
/// To create a new view model, extend this class and override the necessary methods.
///
/// Example:
/// ```dart
/// final class MyViewModel extends BaseViewModel {
///   var _counter = 0;
///   int get counter => _counter;
///   void increment() {
///     _counter++;
///     notifyListeners();
///   }
/// }
/// ```
abstract base class BaseViewModel extends ChangeNotifier implements ViewModel {
  var _disposed = false;
  var _initialized = false;
  var _busy = false;
  dynamic _error;

  @nonVirtual
  @override
  bool get disposed => _disposed;

  @nonVirtual
  @override
  bool get initialized => _initialized;

  @nonVirtual
  @override
  bool get busy => _busy;

  @nonVirtual
  @protected
  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @nonVirtual
  @override
  bool get hasError => _error != null;

  @nonVirtual
  @override
  dynamic get error => _error;

  @nonVirtual
  @protected
  set error(dynamic value) {
    _error = value;
    onError(error);
    notifyListeners();
  }

  /// Callback for error situations. This
  /// is called when [error] is set.
  @protected
  void onError(dynamic error) {}

  /// Initializes the view model.
  /// If overwritten in subclasses, it must call super to
  /// set the initialized flag and notify listeners.
  @override
  @mustCallSuper
  FutureOr<void> initialize() {
    _initialized = true;
    notifyListeners();
  }

  /// Notifies listeners if the view model is not disposed.
  /// This must be called if changes in the view model should be
  /// reflected in the UI.
  @nonVirtual
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  /// Disposes the view model.
  /// If overwritten in a subclass, it must call super to
  /// properly dispose the view model.
  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
