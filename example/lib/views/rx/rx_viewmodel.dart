import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

class RxViewModel extends BaseViewModel {
  final counter = ValueNotifier(0);
  final _counter2 = ValueNotifier(0);

  int get counter2 => _counter2.value;

  @override
  Future<void> initialize() {
    _counter2.addListener(notifyListeners);
    return super.initialize();
  }

  void increment2() {
    _counter2.value += 1;
  }

  @override
  void dispose() {
    _counter2.dispose();
    super.dispose();
  }
}
