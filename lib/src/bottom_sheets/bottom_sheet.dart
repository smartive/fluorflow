import '../overlays/overlay.dart';
import '../viewmodels/base_viewmodel.dart';

abstract base class FluorFlowBottomSheet<TResult,
        TViewModel extends BaseViewModel>
    extends FluorFlowOverlay<TViewModel, TViewModel> {
  const FluorFlowBottomSheet({super.key, required super.completer});
}
