/// Function / Callback type for completing overlays.
/// Overlays are dialogs, bottom sheets, snackbars, etc.
///
/// The Type [T] represents the type of the result that is returned by the overlay.
/// It may be void.
typedef OverlayCompleter<T> = void Function({bool? confirmed, T? result});

/// A set of extensions for [OverlayCompleter].
extension CompleterExtensions<T> on OverlayCompleter<T> {
  /// Confirm the dialog and return the result.
  /// This sets [confirmed] to true.
  void confirm([T? result]) => call(confirmed: true, result: result);

  /// Cancels a dialog and sets [confirmed] to false.
  /// This is used when the user actively declines the dialog.
  void cancel([T? result]) => call(confirmed: false, result: result);

  /// Aborts the dialog and ignores confirmation and the result.
  /// Both values are null.
  void abort() => call();
}
