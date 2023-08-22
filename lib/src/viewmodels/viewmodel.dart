import 'package:flutter/foundation.dart';

abstract interface class ViewModel implements ChangeNotifier {
  bool get disposed;

  bool get initialized;

  bool get busy;

  bool get hasError;

  dynamic get error;

  Future<void> initialize();
}
