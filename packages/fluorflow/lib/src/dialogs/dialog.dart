import '../overlays/overlay.dart';
import '../viewmodels/viewmodel.dart';

/// An abstract base class for FluorFlow dialogs.
///
/// This class extends [FluorFlowOverlay] and provides a base implementation for dialogs in the FluorFlow package.
/// It is intended to be subclassed and customized for specific dialog implementations.
///
/// The generic type parameters are:
/// - [TResult]: The type of the result that the dialog returns. (Defaults to `dynamic` if not specified)
/// - [TViewModel]: The type of the view model associated with the dialog.
///
/// If no view model is required, a simple version of the dialog can be used.
///
/// Example usage:
/// ```dart
/// class MyDialog extends FluorFlowDialog<int, MyViewModel> {
///   const MyDialog({super.key, required super.completer});
/// }
/// ```
abstract base class FluorFlowDialog<TResult, TViewModel extends ViewModel>
    extends FluorFlowOverlay<TResult, TViewModel> {
  const FluorFlowDialog({super.key, required super.completer});
}
