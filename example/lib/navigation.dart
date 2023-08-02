import 'package:example/app.router.dart';
import 'package:fluorflow/locator.dart';
import 'package:fluorflow/services.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final _nav = locator<NavigationService>();

  Navigation({super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          TextButton(onPressed: _nav.rootToHomeView, child: const Text('Home')),
          TextButton(onPressed: _nav.rootToRxView, child: const Text('Rx')),
          TextButton(
              onPressed: _nav.rootToMasterView,
              child: const Text('Master/detail')),
        ],
      );
}
