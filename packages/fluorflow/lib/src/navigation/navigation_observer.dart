import 'package:flutter/material.dart';

typedef RouteHistory = List<Route<dynamic>>;

final class FluorflowNavigatorObserver extends NavigatorObserver {
  final _history = RouteHistory.empty(growable: true);

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

@visibleForTesting
RouteHistory getRouteHistory(FluorflowNavigatorObserver observer) =>
    observer._history;
