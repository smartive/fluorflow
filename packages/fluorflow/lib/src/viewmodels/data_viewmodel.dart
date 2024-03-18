import 'package:flutter/foundation.dart';

import 'base_viewmodel.dart';

/// "Data" view model. Contains a data of type [TData] object that is observed for changes.
/// This view model is used to manage complex data operations and to notify the UI when the data changes.
/// The data can be of any type and is stored in a [ValueNotifier]. The data must be initialized
/// with a default value (synchronously) and can be changed at any time. To initialize data with
/// an asynchronous operation, the [initialize] method can be overridden.
///
/// If the [initialize] method is overridden, it must call super to set the initialized flag.
/// Thus, if your async operation fails, the overwriting method is responsible to set the error
/// and still call initialize after the operation is done.
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
///   HomeViewModel() : super(const LoadingState());
///
///   void loadData() async {
///     await Future.delayed(const Duration(seconds: 2));
///     data = const LoadedState('Hello, World!');
///   }
/// }
/// ```
///
/// Example where data is loaded asynchronously:
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
///   HomeViewModel() : super(const LoadingState());
///
///   @override
///   FutureOr<void> initialize() async {
///     await Future.delayed(const Duration(seconds: 2));
///     data = const LoadedState('Hello, World!');
///     await super.initialize();
///   }
/// }
/// ```
abstract base class DataViewModel<TData> extends BaseViewModel {
  final ValueNotifier<TData> _data;

  /// Creates the data view model with initial data.
  /// The data is required to initialize the [data] value
  /// notifier with some default value. The flag [notifyOnDataChange]
  /// indicates if the view model should notify listeners (by default) when the data changes.
  /// If this is set to false, changes to the data field will not automatically trigger
  /// a [notifyListeners] call.
  DataViewModel(TData initialData, [bool notifyOnDataChange = true])
      : _data = ValueNotifier(initialData) {
    if (notifyOnDataChange) {
      _data.addListener(notifyListeners);
    }
  }

  /// Return the data notifier for the view model. This can be used
  /// to add additional listeners to data changes.
  @nonVirtual
  ValueNotifier<TData> get dataNotifier => _data;

  /// Get the current data value ([TData]).
  @nonVirtual
  TData get data => _data.value;

  /// Set the data value ([TData]).
  /// Setting the data will trigger a [notifyListeners] call
  /// if the view model was created with the [notifyOnDataChange]
  /// flag set to true.
  @nonVirtual
  @protected
  set data(TData value) {
    _data.value = value;
  }
}
