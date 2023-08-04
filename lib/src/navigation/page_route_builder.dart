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

class LeftToRightFadePageRouteBuilder extends PageRouteBuilder {
  LeftToRightFadePageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(1.0, 0.0),
                            ).animate(secondaryAnimation),
                            child: child),
                      ),
                    ));
}

class RightToLeftFadePageRouteBuilder extends PageRouteBuilder {
  RightToLeftFadePageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(-1.0, 0.0),
                            ).animate(secondaryAnimation),
                            child: child),
                      ),
                    ));
}

class TopToBottomFadePageRouteBuilder extends PageRouteBuilder {
  TopToBottomFadePageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, -1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(0.0, 1.0),
                            ).animate(secondaryAnimation),
                            child: child),
                      ),
                    ));
}

class BottomToTopFadePageRouteBuilder extends PageRouteBuilder {
  BottomToTopFadePageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(0.0, -1.0),
                            ).animate(secondaryAnimation),
                            child: child),
                      ),
                    ));
}

class LeftToRightPageRouteBuilder extends PageRouteBuilder {
  LeftToRightPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(1.0, 0.0),
                          ).animate(secondaryAnimation),
                          child: child),
                    ));
}

class RightToLeftPageRouteBuilder extends PageRouteBuilder {
  RightToLeftPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(-1.0, 0.0),
                          ).animate(secondaryAnimation),
                          child: child),
                    ));
}

class TopToBottomPageRouteBuilder extends PageRouteBuilder {
  TopToBottomPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, -1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(0.0, 1.0),
                          ).animate(secondaryAnimation),
                          child: child),
                    ));
}

class BottomToTopPageRouteBuilder extends PageRouteBuilder {
  BottomToTopPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(0.0, -1.0),
                          ).animate(secondaryAnimation),
                          child: child),
                    ));
}

class ZoomInPageRouteBuilder extends PageRouteBuilder {
  ZoomInPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    ScaleTransition(
                      scale: animation,
                      child: child,
                    ));
}
