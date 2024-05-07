import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

Widget mockApp(
  Widget child, {
  bool withScaffold = true,
}) =>
    MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      navigatorObservers: [NavigationService.observer],
      home: withScaffold ? Scaffold(body: child) : child,
    );
