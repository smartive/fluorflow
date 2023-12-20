import '../overlays/overlay.dart';
import '../viewmodels/base_viewmodel.dart';

abstract base class FluorFlowDialog<TResult, TViewModel extends BaseViewModel>
    extends FluorFlowOverlay<TViewModel, TViewModel> {
  const FluorFlowDialog({super.key, required super.completer});
}
