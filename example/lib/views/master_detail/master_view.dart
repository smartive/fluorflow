import 'package:example/app.router.dart';
import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/locator.dart';
import 'package:fluorflow/services.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';

@Routable()
class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('FluorFlow - Master Detail - Master'),
      ),
      bottomNavigationBar: Navigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
                  'Navigate (push) to detail view with argument "Hello World".')),
          TextButton(
              onPressed: () {
                locator<NavigationService>().navigateToDetailView(
                  arg: 'hello',
                  namedArg: 'world',
                );
              },
              child: const Text('increment')),
        ],
      ));
}
