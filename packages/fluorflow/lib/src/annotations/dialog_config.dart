import '../navigation/route_builder.dart';

/// Configuration class for dialogs.
class DialogConfig {
  /// The default barrier (background) color for the dialog.
  final int defaultBarrierColor;

  /// The page route builder for the dialog.
  final Type? pageRouteBuilder;

  /// The route builder for the dialog.
  /// The routeBuilder defines the transition animations for the dialog.
  /// If set to [RouteBuilder.custom], a [pageRouteBuilder] must be provided.
  final RouteBuilder routeBuilder;

  /// Customize the behaviour of a dialog / simple dialog with a [DialogConfig].
  const DialogConfig({
    this.pageRouteBuilder,
    this.routeBuilder = RouteBuilder.noTransition,
    this.defaultBarrierColor = 0x80000000,
  });
}
