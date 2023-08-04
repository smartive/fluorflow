// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/views/home/home_view.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  homeView('/home-view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.homeView.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.HomeView(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  void rootToHomeView() => rootTo(AppRoute.homeView.path);
}
