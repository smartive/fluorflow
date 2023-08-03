import 'package:flutter/foundation.dart';

import 'base_viewmodel.dart';

abstract class StateViewModel<TState> extends BaseViewModel {
  late final ValueNotifier<TState> _state;

  TState get state => initialized
      ? _state.value
      : (throw StateError('ViewModel state is not initialized.'));

  @protected
  set state(TState value) {
    _state.value = value;
  }

  @protected
  bool get registerStateListener => true;

  @protected
  Future<TState> initializeState();

  @protected
  void onStateInitializeError(dynamic error) {}

  @override
  @mustCallSuper
  Future<void> initialize() async {
    try {
      _state = ValueNotifier(await initializeState());
      if (registerStateListener) {
        _state.addListener(notifyListeners);
      }
      super.initialize();
    } catch (e) {
      error = e;
      onStateInitializeError(e);
    }
  }
}
