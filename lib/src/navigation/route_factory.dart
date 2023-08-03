import 'package:flutter/widgets.dart';

typedef RouteMap = Map<String, RouteFactory>;

RouteFactory generateRouteFactory(RouteMap map) =>
    (settings) => map[settings.name]?.call(settings);
