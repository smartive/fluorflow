import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../viewmodels/base_viewmodel.dart';

abstract base class FluorFlowView<TViewModel extends BaseViewModel>
    extends StatelessWidget {
  const FluorFlowView({super.key});

  TViewModel viewModelBuilder(BuildContext context);

  Widget builder(BuildContext context, TViewModel viewModel, Widget? child);

  Widget? staticChildBuilder(BuildContext context) => null;

  void onViewModelCreated(TViewModel viewModel) {}

  @override
  Widget build(BuildContext context) {
    final viewModel = viewModelBuilder(context);
    onViewModelCreated(viewModel);
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => viewModel.initialize());
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => builder(context, viewModel, child),
      child: staticChildBuilder(context),
    );
  }
}
