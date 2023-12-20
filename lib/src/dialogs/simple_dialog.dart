import '../overlays/simple_overlay.dart';

abstract base class FluorFlowSimpleDialog<TResult>
    extends FluorFlowSimpleOverlay<TResult> {
  const FluorFlowSimpleDialog({super.key, required super.completer});
}
