import 'package:flutter/widgets.dart';

class NoTransitionPageRouteBuilder extends PageRouteBuilder {
  NoTransitionPageRouteBuilder({super.settings, required super.pageBuilder});
}

class FadeInPageRouteBuilder extends PageRouteBuilder {
  FadeInPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child));
}
