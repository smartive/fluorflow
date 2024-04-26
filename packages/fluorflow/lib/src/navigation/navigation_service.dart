import 'package:flutter/material.dart';

import '../overlays/overlay.dart';

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
  static final _navigator = _NavigationObserver();

  /// Static navigator key to be used in the main entrypoint of the app.
  /// This allows navigation without context of the build method.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Default Root Navigator Key');

  /// Static navigator observer to be used in the main entrypoint of the app.
  /// Required for adjusting the navigation stack.
  static final NavigatorObserver observer = _navigator;

  /// Returns the current route name (or an empty string if no route
  /// matches).
  String get currentRoute => _navigator.currentRoute?.settings.name ?? '';

  /// Returns the current route arguments (`dynamic` typed).
  dynamic get currentArguments => _navigator.currentRoute?.settings.arguments;

  /// Navigate "back" and return an optional result.
  void back<T>([T? result]) => navigatorKey.currentState?.canPop() == true
      ? navigatorKey.currentState?.pop(result)
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
    bool preventDuplicates = true,
  }) =>
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);

  /// Navigate to a new route and replace the current route on the
  /// navigation stack.
  void replaceWith(
    String routeName, {
    dynamic arguments,
    bool preventDuplicates = true,
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
    if (navigatorKey.currentState == null ||
        navigatorKey.currentState!.overlay == null) {
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
  }) {
    if (navigatorKey.currentState == null ||
        navigatorKey.currentState!.overlay == null) {
      return Future.value(null);
    }

    return Navigator.of(navigatorKey.currentState!.overlay!.context,
            rootNavigator: useRootNavigator)
        .push(ModalBottomSheetRoute<TResult>(
      builder: (context) => sheet,
      isScrollControlled: fullscreen,
      enableDrag: draggable,
      showDragHandle: showDragHandle,
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

final class _NavigationObserver extends NavigatorObserver {
  final _history = List<Route<dynamic>>.empty(growable: true);

  Route<dynamic>? get currentRoute =>
      _history.where((r) => r.isCurrent).firstOrNull;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _history.add(route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _history.remove(route);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _history.remove(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      _history.remove(oldRoute);
    }
    if (newRoute != null) {
      _history.add(newRoute);
    }
  }
}
