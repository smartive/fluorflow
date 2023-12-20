import '../overlays/completer.dart';
import '../viewmodels/base_viewmodel.dart';
import '../views/fluorflow_view.dart';

abstract base class FluorFlowOverlay<TResult, TViewModel extends BaseViewModel>
    extends FluorFlowView<TViewModel> {
  final OverlayCompleter<TResult> completer;

  const FluorFlowOverlay({super.key, required this.completer});
}
