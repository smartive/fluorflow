import 'package:flutter/foundation.dart';

import 'viewmodel.dart';

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

  @protected
  void onError(dynamic error) {}

  @override
  @mustCallSuper
  Future<void> initialize() async {
    _initialized = true;
    notifyListeners();
  }

  @nonVirtual
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
