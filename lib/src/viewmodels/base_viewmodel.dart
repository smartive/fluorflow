import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  var _disposed = false;
  var _initialized = false;
  var _busy = false;
  dynamic _error;

  bool get disposed => _disposed;

  bool get initialized => _initialized;

  bool get busy => _busy;

  @nonVirtual
  @protected
  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get hasError => _error != null;

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
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
