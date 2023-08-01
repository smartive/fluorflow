import 'package:flutter/widgets.dart';

/// A custom page route builder that provides a page transition without any animation.
class NoTransitionPageRouteBuilder extends PageRouteBuilder {
  NoTransitionPageRouteBuilder({super.settings, required super.pageBuilder});
}

/// A custom page route builder that provides a fade-in transition effect.
class FadeInPageRouteBuilder extends PageRouteBuilder {
  FadeInPageRouteBuilder({super.settings, required super.pageBuilder})
      : super(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child));
}

/// A custom page route builder that provides a left to right fade transition effect.
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

/// A custom page route builder that provides a right to left fade transition effect.
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

/// A custom page route builder that provides a top to bottom fade transition effect.
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

/// A custom page route builder that provides a bottom to top fade transition effect.
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

/// A custom page route builder that provides a left to right transition effect.
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

/// A custom page route builder that provides a right to left transition effect.
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

/// A custom page route builder that provides a top to bottom transition effect.
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

/// A custom page route builder that provides a bottom to top transition effect.
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

/// A custom page route builder that provides a zoom-in transition effect.
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
