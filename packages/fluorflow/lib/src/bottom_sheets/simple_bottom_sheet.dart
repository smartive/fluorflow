import '../overlays/simple_overlay.dart';

/// A base class for creating simple bottom sheets in FluorFlow.
///
/// This abstract class extends [FluorFlowSimpleOverlay] and provides a base
/// implementation for creating bottom sheets in FluorFlow. It takes a generic
/// type parameter `TResult` which represents the type of the result that will
/// be returned when the bottom sheet is dismissed. The returntype can be `dynamic` (default)
/// or `void` as well.
///
/// Subclasses should override this class and provide their own implementation
/// for the bottom sheet content.
///
/// When more complex UI and behavior is required, use [FluorFlowBottomSheet].
abstract base class FluorFlowSimpleBottomSheet<TResult>
    extends FluorFlowSimpleOverlay<TResult> {
  const FluorFlowSimpleBottomSheet({super.key, required super.completer});
}
