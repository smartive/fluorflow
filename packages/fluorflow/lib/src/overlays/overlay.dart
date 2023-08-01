import '../overlays/completer.dart';
import '../viewmodels/viewmodel.dart';
import '../views/fluorflow_view.dart';

/// Base class for fluorflow overlays such as dialogs and bottom sheets.
/// Utilizses a view model for complex UI operations.
abstract base class FluorFlowOverlay<TResult, TViewModel extends ViewModel>
    extends FluorFlowView<TViewModel> {
  final OverlayCompleter<TResult> completer;

  const FluorFlowOverlay({super.key, required this.completer});
}
