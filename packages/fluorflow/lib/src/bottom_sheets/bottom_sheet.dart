import '../overlays/overlay.dart';
import '../viewmodels/viewmodel.dart';

/// An abstract base class for FluorFlow bottom sheets.
///
/// This class extends [FluorFlowOverlay] and provides a base implementation for bottom sheets in the FluorFlow package.
/// It takes a generic type parameter [TResult] representing the result type of the bottom sheet,
/// and [TViewModel] representing the view model type.
///
/// The return type can be omitted if no result is required from the bottom sheet. Then the return
/// type defaults to `dynamic`. Further, it can be set to `void` explicitly if no result is required.
///
/// If no view model is required, a simple version of the bottom sheet can be used.
///
/// Subclasses of this class should provide their own implementation for the bottom sheet UI and behavior.
///
/// Example usage:
/// ```dart
/// class MyBottomSheet extends FluorFlowBottomSheet<String, MyViewModel> {
///   const MyBottomSheet({super.key, required super.completer});
///
///   // Provide implementation for the bottom sheet UI and behavior
/// }
/// ```
abstract base class FluorFlowBottomSheet<TResult, TViewModel extends ViewModel>
    extends FluorFlowOverlay<TResult, TViewModel> {
  const FluorFlowBottomSheet({super.key, required super.completer});
}
