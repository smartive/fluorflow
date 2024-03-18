import '../navigation/route_builder.dart';

/// Configuration class for dialogs.
class DialogConfig {
  /// The default barrier (background) color for the dialog.
  final int defaultBarrierColor;

  /// The default value for "barrierDismissible" for the dialog.
  /// Defines whether the dialog can be dismissed by tapping the barrier.
  final bool defaultBarrierDismissible;

  /// The page route builder for the dialog.
  final Type? pageRouteBuilder;

  /// The route builder for the dialog.
  /// The routeBuilder defines the transition animations for the dialog.
  /// If a [pageRouteBuilder] is provided, the custom builder is used.
  final RouteBuilder routeBuilder;

  /// Customize the behaviour of a dialog / simple dialog with a [DialogConfig].
  const DialogConfig({
    this.pageRouteBuilder,
    this.routeBuilder = RouteBuilder.noTransition,
    this.defaultBarrierColor = 0x80000000,
    this.defaultBarrierDismissible = false,
  });
}
