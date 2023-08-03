import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

typedef RouteMap = Map<String, RouteFactory>;
RouteFactory generateRouteFactory(RouteMap map) =>
    (settings) => map[settings.name]?.call(settings);

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
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      Get.toNamed<T?>(
        routeName,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );

  Future<T?>? replaceWith<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    RouteTransitionsBuilder? transition,
  }) =>
      Get.offNamed<T?>(
        routeName,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );

  Future<T?>? rootTo<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      Get.offAllNamed<T?>(
        routeName,
        arguments: arguments,
        id: id,
        parameters: parameters,
      );
}
