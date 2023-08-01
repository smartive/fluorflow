import 'dart:async';

import 'package:flutter/foundation.dart';

import 'base_viewmodel.dart';

/// "Data" view model. Contains a data of type [TData] object that is observed for changes.
/// This view model is used to manage complex data operations and to notify the UI when the data changes.
/// The data can be of any type and is stored in a [ValueNotifier]. Since the data
/// is initialized with a call, accessing the data before the initialize method is called
/// results in a state error.
///
/// It combines well with packages such as "freezed" to manage view state with
/// sealed classes.
///
/// Example:
/// ```dart
/// sealed class HomeState {
///   const HomeState();
/// }
///
/// final class LoadingState extends HomeState {
///   const LoadingState();
/// }
///
/// final class LoadedState extends HomeState {
///   final String data;
///
///   const LoadedState(this.data);
/// }
///
/// final class HomeViewModel extends DataViewModel<HomeState> {
///   @override
///   FutureOr<HomeState> initializeData() => const LoadingState();
///
///   void loadData() async {
///     await Future.delayed(const Duration(seconds: 2));
///     data = const LoadedState('Hello, World!');
///   }
/// }
/// ```
abstract base class DataViewModel<TData> extends BaseViewModel {
  late final ValueNotifier<TData> _data;

  /// Return the data notifier for the view model. This can be used
  /// to add additional listeners to data changes.
  ///
  /// If the view model is not initialized, a state error is thrown.
  @nonVirtual
  ValueNotifier<TData> get dataNotifier =>
      initialized ? _data : (throw StateError('ViewModel is not initialized.'));

  /// Get the current data value ([TData]).
  ///
  /// If the view model is not initialized, a state error is thrown.
  @nonVirtual
  TData get data => initialized
      ? _data.value
      : (throw StateError('ViewModel is not initialized.'));

  /// Set the data value ([TData]).
  /// Setting the data will trigger a [notifyListeners] call.
  @nonVirtual
  @protected
  set data(TData value) {
    _data.value = value;
  }

  /// Indicates whether the view model should notify listeners when the data changes.
  /// This may be overwritten by subclasses to disable the notification.
  @protected
  bool get notifyOnDataChange => true;

  /// Initializes the data of the view model. It may return a Future or the data directly.
  @protected
  FutureOr<TData> initializeData();

  /// Callback for error situations when initializing the data.
  /// This also triggers the [onError] callback.
  @protected
  void onDataInitializeError(dynamic error) {}

  /// Initializes the data view model.
  /// The data of the view model is initialized and a listener is added to the data
  /// (if [notifyOnDataChange] is set).
  ///
  /// Subclasses that overwrite this method must call super to properly initialize the data.
  @override
  @mustCallSuper
  FutureOr<void> initialize() async {
    try {
      _data = ValueNotifier(await initializeData());
      if (notifyOnDataChange) {
        _data.addListener(notifyListeners);
      }
      await super.initialize();
    } catch (e) {
      error = e;
      onDataInitializeError(e);
    }
  }
}
