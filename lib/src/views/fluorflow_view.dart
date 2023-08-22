import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../viewmodels/viewmodel.dart';

abstract base class FluorFlowView<TViewModel extends ViewModel>
    extends StatefulWidget {
  const FluorFlowView({super.key});

  @protected
  TViewModel viewModelBuilder(BuildContext context);

  @protected
  Widget builder(BuildContext context, TViewModel viewModel, Widget? child);

  @protected
  Widget? staticChildBuilder(BuildContext context) => null;

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
