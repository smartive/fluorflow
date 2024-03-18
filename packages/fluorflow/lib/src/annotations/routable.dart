import '../navigation/route_builder.dart';

/// An annotation class used to mark a class / view as routable.
///
/// The [Routable] class is used to annotate a class that can be navigated to within a routing system.
/// It provides options for configuring the navigation behavior, such as whether to navigate to the view,
/// replace the current route with the view, or make a root navigation to the view.
///
/// The [path] parameter can be used to specify a custom path for the routable class.
/// The [pageRouteBuilder] parameter can be used to specify a custom page route builder for the routable class.
/// The [routeBuilder] parameter can be used to specify a custom route builder for the routable class.
/// When a [pageRouteBuilder] is provided, the [routeBuilder] is ignored.
/// The [navigateToExtension] defines whether the method extension on the navigation service contains a navigateTo method.
/// The [replaceWithExtension] defines whether the method extension on the navigation service contains a replaceWith method.
/// The [rootToExtension] defines whether the method extension on the navigation service contains a rootTo method.
///
/// Example usage:
/// ```dart
/// @Routable(
///   replaceWithExtension: false,
///   rootToExtension: false,
///   path: '/home',
///   routeBuilder: RouteBuilder.leftToRight,
/// )
/// class MyRoutableClass extends FluorFlowView {
///   // class implementation
/// }
/// ```
class Routable {
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
