// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/views/home/home_view.dart' as _i3;
import 'package:example/views/master_detail/detail_view.dart' as _i4;
import 'package:example/views/master_detail/master_view.dart' as _i5;
import 'package:example/views/rx/rx_view.dart' as _i6;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  homeView('/home-view'),
  detailView('/detail-view'),
  masterView('/master-view'),
  rxView('/rx-view');

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
      ),
  AppRoute.detailView.path: (data) => _i2.ZoomInPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as DetailViewArguments);
          return _i4.DetailView(
            args.arg,
            namedArg: args.namedArg,
            optionalArg: args.optionalArg,
            defaultedArg: args.defaultedArg,
          );
        },
      ),
  AppRoute.masterView.path: (data) => _i2.FadeInPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i5.MasterView(),
      ),
  AppRoute.rxView.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i6.RxView(),
      ),
};

class DetailViewArguments {
  const DetailViewArguments({
    required this.arg,
    required this.namedArg,
    this.optionalArg,
    this.defaultedArg = 'default',
  });

  final String arg;

  final String namedArg;

  final String? optionalArg;

  final String defaultedArg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToHomeView<T>({bool preventDuplicates = true}) =>
      navigateTo(
        AppRoute.homeView.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithHomeView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.homeView.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToHomeView() => rootTo(AppRoute.homeView.path);
  Future<T?>? navigateToDetailView<T>({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.detailView.path,
        preventDuplicates: preventDuplicates,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  void replaceWithDetailView({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.detailView.path,
        preventDuplicates: preventDuplicates,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  void rootToDetailView({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
  }) =>
      rootTo(
        AppRoute.detailView.path,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  Future<T?>? navigateToMasterView<T>({bool preventDuplicates = true}) =>
      navigateTo(
        AppRoute.masterView.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithMasterView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.masterView.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToMasterView() => rootTo(AppRoute.masterView.path);
  Future<T?>? navigateToRxView<T>({bool preventDuplicates = true}) =>
      navigateTo(
        AppRoute.rxView.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithRxView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.rxView.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToRxView() => rootTo(AppRoute.rxView.path);
}
