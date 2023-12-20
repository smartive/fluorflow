import '../overlays/simple_overlay.dart';

abstract base class FluorFlowSimpleBottomSheet<TResult>
    extends FluorFlowSimpleOverlay<TResult> {
  const FluorFlowSimpleBottomSheet({super.key, required super.completer});
}
