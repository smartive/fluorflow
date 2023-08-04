import '../navigation/route_builder.dart';

final class Routable {
  final bool navigateToExtension;
  final bool replaceWithExtension;
  final bool rootToExtension;

  final String? path;

  final Type? pageRouteBuilder;
  final RouteBuilder routeBuilder;

  const Routable({
    this.navigateToExtension = true,
    this.replaceWithExtension = true,
    this.rootToExtension = true,
    this.path,
    this.pageRouteBuilder,
    this.routeBuilder = RouteBuilder.noTransition,
  });
}
