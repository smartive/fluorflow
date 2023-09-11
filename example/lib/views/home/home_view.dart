import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/widgets.dart';

import 'home_viewmodel.dart';

@Routable(navigateToExtension: false, replaceWithExtension: false)
final class HomeView extends FluorFlowView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      const Placeholder();

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
