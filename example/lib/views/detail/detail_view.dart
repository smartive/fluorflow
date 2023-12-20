import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

import 'detail_viewmodel.dart';

@Routable(
    replaceWithExtension: false,
    rootToExtension: false,
    routeBuilder: RouteBuilder.leftToRight)
final class DetailView extends FluorFlowView<DetailViewModel> {
  const DetailView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DetailViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Detail Page'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: viewModel.back,
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: viewModel.showBottomSheet,
                child: const Text('Show Bottom Sheet'),
              ),
            ],
          ),
        ),
      );
  @override
  DetailViewModel viewModelBuilder(BuildContext context) => DetailViewModel();
}
