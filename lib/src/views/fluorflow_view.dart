import 'package:flutter/widgets.dart';

import '../viewmodels/base_viewmodel.dart';

abstract class FluorFlowView<TViewModel extends BaseViewModel>
    extends StatelessWidget {
  const FluorFlowView({super.key});

  TViewModel viewModelBuilder(BuildContext context);

  Widget builder(BuildContext context, TViewModel viewModel, Widget? child);

  Widget? staticChildBuilder(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    final viewModel = viewModelBuilder(context);
    viewModel.initialize();
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => builder(context, viewModel, child),
      child: staticChildBuilder(context),
    );
  }
}
