import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
///       navigatorObservers: [NavigationService.observer()],
///     );
///   }
/// }
/// ```
class NavigationService {
  /// Static navigator key to be used in the main entrypoint of the app.
  /// This allows navigation without context of the build method.
  static GlobalKey<NavigatorState> get navigatorKey => Get.key;

  /// Static navigator observer to be used in the main entrypoint of the app.
  /// Required for adjusting the navigation stack.
  static NavigatorObserver observer() => GetObserver(null, Get.routing);

  /// Returns the previous route name.
  String get previousRoute => Get.previousRoute;

  /// Returns the current route name.
  String get currentRoute => Get.currentRoute;

  /// Returns the current route arguments (`dynamic` typed).
  dynamic get currentArguments => Get.arguments;

  /// Returns the current route arguments (`T` typed).
  T typedArguments<T>() => Get.arguments;

  /// Navigate "back" and return an optional result.
  void back<T>({T? result}) => Get.back<T>(result: result);

  /// Pops the route stack until the predicate is fulfilled.
  void popUntil(RoutePredicate predicate) => Get.until(predicate);

  /// Navigate to a new route and return an optional result
  /// when back is called from the new route. This pushes
  /// the new route onto the navigation stack.
  Future<T?>? navigateTo<T>(
    String routeName, {
    dynamic arguments,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      Get.toNamed<T?>(
        routeName,
        arguments: arguments,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );

  /// Navigate to a new route and replace the current route on the
  /// navigation stack.
  void replaceWith(
    String routeName, {
    dynamic arguments,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    RouteTransitionsBuilder? transition,
  }) =>
      Get.offNamed(
        routeName,
        arguments: arguments,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );

  /// Navigate to a new route and remove all previous routes from the
  /// navigation stack.
  void rootTo(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) =>
      Get.offAllNamed(
        routeName,
        arguments: arguments,
        parameters: parameters,
      );
}
