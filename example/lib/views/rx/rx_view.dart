import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';
import 'rx_viewmodel.dart';

@Routable()
class RxView extends FluorFlowView<RxViewModel> {
  const RxView({super.key});

  @override
  Widget builder(BuildContext context, RxViewModel viewModel, Widget? child) =>
      Scaffold(
          appBar: AppBar(
            title: const Text('FluorFlow - Reactive Counter'),
          ),
          bottomNavigationBar: Navigation(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                      'Reactive Element that only rebuilds when the counter changes.')),
              Center(
                  child: ListenableBuilder(
                      listenable: viewModel.counter,
                      builder: (context, child) =>
                          Text('Counter Example: ${viewModel.counter.value}'))),
              TextButton(
                  onPressed: () => viewModel.counter.value += 1,
                  child: const Text('increment')),
              const SizedBox(height: 20),
              const Center(
                  child: Text(
                      'Reactive Element that is listened to by the viewmodel.')),
              Center(child: Text('Counter Example: ${viewModel.counter2}')),
              TextButton(
                  onPressed: viewModel.increment2,
                  child: const Text('increment')),
            ],
          ));

  @override
  RxViewModel viewModelBuilder(BuildContext context) => RxViewModel();
}
