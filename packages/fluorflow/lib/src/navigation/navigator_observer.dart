import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef RouteHistory = List<Route<dynamic>>;

final class FluorflowNavigatorObserver extends NavigatorObserver {
  int? _maxLength;
  var _pruneRegistered = false;
  final _history = RouteHistory.empty(growable: true);

  /// The maximal history length. If set, the history
  /// will never exceed this length. On navigation, the
  /// oldest entries will be pruned to prevent memory leaks.
  /// If set to `null`, the history will grow indefinitely.
  ///
  /// Must be a positive, non-zero integer, or `null`.
  ///
  /// Defaults to `null`.
  ///
  /// Can be used directly in the main entrypoint of the app:
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: NavigationService.navigatorKey,
  ///   navigatorObservers: [
  ///     NavigationService.observer
  ///       ..maxLength = 10,
  ///   ],
  ///   // other things like onGenerateRoute and initialRoute
  /// );
  /// ```
  set maxLength(int? value) {
    assert(value == null || value > 0);
    _maxLength = value;
  }

  Route<dynamic>? get currentRoute =>
      _history.where((r) => r.isCurrent).firstOrNull;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.add(route);
    if (_maxLength != null &&
        _history.length > _maxLength! &&
        !_pruneRegistered) {
      _pruneRegistered = true;
      // The scheduler is used because the navigator asserts with a lock
      // if methods are called from within another navigation method.
      // ref: https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        while (_history.length > _maxLength!) {
          navigator?.removeRoute(_history.first);
        }
        _pruneRegistered = false;
      });
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _history.remove(route);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _history.remove(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    int? index;
    if (oldRoute != null) {
      index = _history.indexOf(oldRoute);
    }

    if (newRoute != null && index != null) {
      _history[index] = newRoute;
    } else {
      _history.remove(oldRoute);
    }
  }
}

@visibleForTesting
RouteHistory getRouteHistory(FluorflowNavigatorObserver observer) =>
    observer._history;
