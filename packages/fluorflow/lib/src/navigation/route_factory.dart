import 'package:flutter/widgets.dart';

/// Map that contains a set of routes (by name) and their corresponding route factories.
typedef RouteMap = Map<String, RouteFactory>;

/// Create a route factory for a given route map.
RouteFactory generateRouteFactory(RouteMap map) =>
    (settings) => map[settings.name]?.call(settings);
