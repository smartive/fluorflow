import 'package:fluorflow/fluorflow.dart';
import 'package:flutter/material.dart';

import 'app.locator.dart';
import 'app.router.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FluorFlow Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoute.homeView.path,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: NavigationService.navigatorKey,
        navigatorObservers: [NavigationService.observer],
      );
}
