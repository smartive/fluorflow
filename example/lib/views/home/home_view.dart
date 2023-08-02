import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/ui.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';
import 'home_viewmodel.dart';

@Routable()
class HomeView extends FluorFlowView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      Scaffold(
          appBar: AppBar(
            title: const Text('FluorFlow - Counter'),
          ),
          bottomNavigationBar: Navigation(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Counter Example: ${viewModel.counter}')),
              TextButton(
                  onPressed: viewModel.increment,
                  child: const Text('increment'))
            ],
          ));

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
