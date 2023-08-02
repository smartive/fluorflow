import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

import 'home_viewmodel.dart';

class HomeView extends FluorFlowView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      Scaffold(
          appBar: AppBar(
            title: const Text('FluorFlow'),
          ),
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
