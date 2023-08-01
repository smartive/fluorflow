import 'dart:async';

import 'package:flutter/foundation.dart';

/// A base view model interface.
///
/// This interface defines the common properties and methods that a view model should have.
abstract interface class ViewModel implements ChangeNotifier {
  /// Indicates whether the view model has been disposed.
  bool get disposed;

  /// Indicates whether the view model has been initialized.
  bool get initialized;

  /// Indicates whether the view model is currently busy.
  bool get busy;

  /// Indicates whether the view model has encountered an error.
  bool get hasError;

  /// The error object associated with the view model.
  dynamic get error;

  /// Initializes the view model.
  ///
  /// This method should be called to initialize the view model before using it.
  FutureOr<void> initialize();
}
