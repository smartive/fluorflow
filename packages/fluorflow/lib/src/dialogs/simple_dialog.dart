import '../overlays/simple_overlay.dart';

/// Base class for creating simple dialogs in FluorFlow.
///
/// This abstract class extends [FluorFlowSimpleOverlay] and provides a base implementation for simple dialogs.
/// It takes a [completer] parameter which is required for handling the result of the dialog.
/// Subclasses should override this class and provide their own implementation.
///
/// More complex UI and behavior can be achieved by using [FluorFlowDialog].
abstract base class FluorFlowSimpleDialog<TResult>
    extends FluorFlowSimpleOverlay<TResult> {
  const FluorFlowSimpleDialog({super.key, required super.completer});
}
