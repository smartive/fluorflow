import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

import 'home_viewmodel.dart';

@Routable(
    navigateToExtension: false,
    replaceWithExtension: false,
    routeBuilder: RouteBuilder.fadeIn)
final class HomeView extends FluorFlowView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Home Page'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: viewModel.goToDetail,
                child: const Text('Navigate to Detail'),
              ),
              ElevatedButton(
                onPressed: viewModel.showTestDialog,
                child: const Text('Show Dialog'),
              ),
              ElevatedButton(
                onPressed: viewModel.showSmallDialog,
                child: const Text('Show Small Dialog'),
              ),
            ],
          ),
        ),
      );

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
