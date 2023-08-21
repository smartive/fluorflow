import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final class NavigationService {
  static GlobalKey<NavigatorState> get navigatorKey => Get.key;

  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);

  static NavigatorObserver observer() => GetObserver();

  String get previousRoute => Get.previousRoute;

  String get currentRoute => Get.currentRoute;

  dynamic get currentArguments => Get.arguments;

  T typedArguments<T>() => Get.arguments;

  void back<T>({T? result, int? id}) => Get.back<T>(result: result, id: id);

  void popUntil(RoutePredicate predicate, {int? id}) =>
      Get.until(predicate, id: id);

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

@visibleForTesting
base mixin MockableNavigationService implements NavigationService {}
