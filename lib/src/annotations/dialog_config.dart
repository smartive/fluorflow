import '../navigation/route_builder.dart';

final class DialogConfig {
  final int defaultBarrierColor;

  final Type? pageRouteBuilder;
  final RouteBuilder routeBuilder;

  const DialogConfig({
    this.pageRouteBuilder,
    this.routeBuilder = RouteBuilder.noTransition,
    this.defaultBarrierColor = 0x80000000,
  });
}
