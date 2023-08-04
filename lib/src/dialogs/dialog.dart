import '../viewmodels/base_viewmodel.dart';
import '../views/fluorflow_view.dart';
import 'completer.dart';

abstract base class FluorFlowDialog<TResult, TViewModel extends BaseViewModel>
    extends FluorFlowView<TViewModel> {
  final DialogCompleter<TResult> completer;

  const FluorFlowDialog({super.key, required this.completer});
}
