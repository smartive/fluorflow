import 'package:flutter/foundation.dart';

import 'base_viewmodel.dart';

abstract base class DataViewModel<TData> extends BaseViewModel {
  late final ValueNotifier<TData> _data;

  ValueNotifier<TData> get dataNotifier =>
      initialized ? _data : (throw StateError('ViewModel is not initialized.'));

  TData get data => initialized
      ? _data.value
      : (throw StateError('ViewModel is not initialized.'));

  @nonVirtual
  @protected
  set data(TData value) {
    _data.value = value;
  }

  @protected
  bool get notifyOnDataChange => true;

  @protected
  Future<TData> initializeData();

  @protected
  void onDataInitializeError(dynamic error) {}

  @override
  @mustCallSuper
  Future<void> initialize() async {
    try {
      _data = ValueNotifier(await initializeData());
      if (notifyOnDataChange) {
        _data.addListener(notifyListeners);
      }
      super.initialize();
    } catch (e) {
      error = e;
      onDataInitializeError(e);
    }
  }
}
