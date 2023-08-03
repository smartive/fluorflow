import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

@Routable(pageBuilder: FadeInPageRouteBuilder)
class DetailView extends StatelessWidget {
  final String arg;
  final String namedArg;
  final String? optionalArg;
  final String defaultedArg;

  const DetailView(this.arg,
      {required this.namedArg,
      super.key,
      this.optionalArg,
      this.defaultedArg = 'default'});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('FluorFlow - Master Detail - Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Detail page. Args: $arg, $namedArg, $optionalArg')),
          TextButton(
              onPressed: () {
                locator<NavigationService>().back();
              },
              child: const Text('Back')),
        ],
      ));
}
