import 'package:flutter/material.dart';

import '../overlays/overlay.dart';
import 'navigator_observer.dart';

/// A service that provides a set of methods to navigate between routes.
/// One may directly use the [navigateTo] and other methods to navigate dynamically.
/// However, in combination with the `fluorflow_generator`, convenience methods are created
/// as method extensions for this service.
///
/// To allow navigation with this package/service, the main entrypoint of the app needs
/// to be modified. The properties `initialRoute`, `onGenerateRoute`, `navigatorKey`, and
/// `navigatorObservers` need to be set to the corresponding values of this service.
///
/// Example entrypoint:
/// ```dart
/// import 'app.router.dart';
///
/// void main() async {
///   runApp(const MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   const MyApp({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'FluorFlow Demo',
///       theme: ThemeData(
///         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
///         useMaterial3: true,
///       ),
///       initialRoute: AppRoute.homeView.path,
///       onGenerateRoute: onGenerateRoute,
///       navigatorKey: NavigationService.navigatorKey,
///       navigatorObservers: [NavigationService.observer],
///     );
///   }
/// }
/// ```
class NavigationService {
  static final _observer = FluorflowNavigatorObserver();

  /// Static navigator key to be used in the main entrypoint of the app.
  /// This allows navigation without context of the build method.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Default Root Navigator Key');

  /// Static navigator observer to be used in the main entrypoint of the app.
  /// Required for adjusting the navigation stack.
  static final FluorflowNavigatorObserver observer = _observer;

  const NavigationService();

  /// Returns the current route name (or an empty string if no route
  /// matches).
  /// The whole route object (for more advanced usecases) can be accessed
  /// via the `currentRoute` property of the observer.
  String get currentRoute => _observer.currentRoute?.settings.name ?? '';

  /// Returns the current route arguments (`dynamic` typed).
  dynamic get currentArguments => _observer.currentRoute?.settings.arguments;

  /// Returns the previous route name (or `null` if no previous route exists).
  /// The whole route object (for more advanced usecases) can be accessed
  /// via the `previousRoute` property of the observer.
  String? get previousRoute => _observer.previousRoute?.settings.name;

  /// Navigate "back" and return an optional result.
  void back<T>([T? result]) => navigatorKey.currentState?.canPop() == true
      ? navigatorKey.currentState!.pop(result)
      : null;

  /// Pops the route stack until the predicate is fulfilled.
  void popUntil(RoutePredicate predicate) =>
      navigatorKey.currentState?.popUntil(predicate);

  /// Navigate to a new route and return an optional result
  /// when back is called from the new route. This pushes
  /// the new route onto the navigation stack.
  Future<T?>? navigateTo<T>(
    String routeName, {
    dynamic arguments,
  }) =>
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);

  /// Navigate to a new route and replace the current route on the
  /// navigation stack.
  void replaceWith(
    String routeName, {
    dynamic arguments,
  }) =>
      navigatorKey.currentState?.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  /// Navigate to a new route and remove all previous routes from the
  /// navigation stack.
  void rootTo(
    String routeName, {
    dynamic arguments,
  }) =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );

  Future<TResult?> showDialog<TResult>({
    required PageRouteBuilder dialogBuilder,
    Color barrierColor = const Color(0x80000000),
    bool barrierDismissible = false,
  }) {
    if (navigatorKey.currentState?.overlay == null) {
      return Future.value(null);
    }

    return Navigator.of(navigatorKey.currentState!.overlay!.context,
            rootNavigator: true)
        .push(_DialogRoute(
      dialogBuilder: dialogBuilder,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
    ));
  }

  Future<TResult?> showBottomSheet<TResult, TSheet extends FluorFlowOverlay>(
    TSheet sheet, {
    Color barrierColor = const Color(0x80000000),
    bool useRootNavigator = false,
    bool fullscreen = false,
    bool draggable = true,
    bool showDragHandle = false,
    bool useSafeArea = false,
  }) {
    if (navigatorKey.currentState?.overlay == null) {
      return Future.value(null);
    }

    return Navigator.of(navigatorKey.currentState!.overlay!.context,
            rootNavigator: useRootNavigator)
        .push(ModalBottomSheetRoute<TResult>(
      builder: (context) => sheet,
      isScrollControlled: fullscreen,
      enableDrag: draggable,
      showDragHandle: showDragHandle,
      modalBarrierColor: barrierColor,
      useSafeArea: useSafeArea,
    ));
  }

  void closeOverlay<T>({bool? confirmed, T? result}) {
    if (navigatorKey.currentState == null) {
      return;
    }

    Navigator.of(navigatorKey.currentState!.overlay!.context,
            rootNavigator: true)
        .pop((confirmed, result));
  }
}

final class _DialogRoute<T> extends PopupRoute<T> {
  final PageRouteBuilder dialogBuilder;

  @override
  final Color barrierColor;

  @override
  final bool barrierDismissible;

  _DialogRoute({
    required this.dialogBuilder,
    required this.barrierColor,
    required this.barrierDismissible,
  });

  @override
  String? get barrierLabel => barrierDismissible
      ? 'dialog ${dialogBuilder.settings.name} $hashCode'
      : null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      dialogBuilder.buildPage(context, animation, secondaryAnimation);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      dialogBuilder.buildTransitions(
          context, animation, secondaryAnimation, child);

  @override
  Duration get transitionDuration => dialogBuilder.transitionDuration;

  @override
  Duration get reverseTransitionDuration =>
      dialogBuilder.reverseTransitionDuration;
}
