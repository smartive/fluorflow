// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/views/home/home_view.dart' as _i2;
import 'package:example/views/master_detail/detail_view.dart' as _i3;
import 'package:example/views/master_detail/master_view.dart' as _i4;
import 'package:example/views/rx/rx_view.dart' as _i5;
import 'package:fluorflow/services.dart' as _i6;
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
  '/home-view': (data) => _i1.PageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i2.HomeView(),
      ),
  '/detail-view': (data) => _i1.PageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as DetailViewArguments);
          return _i3.DetailView(
            args.arg,
            namedArg: args.namedArg,
            optionalArg: args.optionalArg,
            defaultedArg: args.defaultedArg,
          );
        },
      ),
  '/master-view': (data) => _i1.PageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i4.MasterView(),
      ),
  '/rx-view': (data) => _i1.PageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i5.RxView(),
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

_i1.Route? onGenerateRoute(_i1.RouteSettings settings) =>
    _pages[settings.name]?.call(settings);

extension RouteNavigation on _i6.NavigationService {
  Future<T?>? navigateToHomeView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.homeView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? replaceWithHomeView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.homeView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? rootToHomeView<T>({int? id}) => rootTo(
        AppRoute.homeView.path,
        id: id,
      );
  Future<T?>? navigateToDetailView<T>({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
    int? id,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.detailView.path,
        id: id,
        preventDuplicates: preventDuplicates,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  Future<T?>? replaceWithDetailView<T>({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
    int? id,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.detailView.path,
        id: id,
        preventDuplicates: preventDuplicates,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  Future<T?>? rootToDetailView<T>({
    required String arg,
    required String namedArg,
    String? optionalArg,
    String defaultedArg = 'default',
    int? id,
  }) =>
      rootTo(
        AppRoute.detailView.path,
        id: id,
        arguments: DetailViewArguments(
          arg: arg,
          namedArg: namedArg,
          optionalArg: optionalArg,
          defaultedArg: defaultedArg,
        ),
      );
  Future<T?>? navigateToMasterView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.masterView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? replaceWithMasterView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.masterView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? rootToMasterView<T>({int? id}) => rootTo(
        AppRoute.masterView.path,
        id: id,
      );
  Future<T?>? navigateToRxView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.rxView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? replaceWithRxView<T>({
    int? id,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.rxView.path,
        id: id,
        preventDuplicates: preventDuplicates,
      );
  Future<T?>? rootToRxView<T>({int? id}) => rootTo(
        AppRoute.rxView.path,
        id: id,
      );
}
