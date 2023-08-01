import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../viewmodels/viewmodel.dart';

/// Base class for a view that is managed by a [ViewModel].
/// The view model is created when the view is initialized and disposed when the view is disposed.
///
/// When the notifyListeners method is called on the view model, the view is rebuilt.
///
/// The [staticChildBuilder] allows a non-changing child to be built once and reused.
@immutable
abstract base class FluorFlowView<TViewModel extends ViewModel>
    extends StatefulWidget {
  const FluorFlowView({super.key});

  /// Create the view model for the view.
  @protected
  TViewModel viewModelBuilder(BuildContext context);

  /// Build the view with the view model and the optional static child.
  @protected
  Widget builder(BuildContext context, TViewModel viewModel, Widget? child);

  /// Build the static child for the view.
  /// This allows a static child, that is not dependent on the view model, to be built once and reused.
  @protected
  Widget? staticChildBuilder(BuildContext context) => null;

  /// Called when the view model is created.
  @protected
  void onViewModelCreated(TViewModel viewModel) {}

  @override
  @nonVirtual
  State<FluorFlowView> createState() => _FluorFlowViewState();
}

class _FluorFlowViewState<TViewModel extends ViewModel>
    extends State<FluorFlowView<TViewModel>> {
  late final TViewModel viewModel;

  @override
  void initState() {
    viewModel = widget.viewModelBuilder(context);
    widget.onViewModelCreated(viewModel);
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => viewModel.initialize());
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) => widget.builder(context, viewModel, child),
        child: widget.staticChildBuilder(context),
      );
}
