import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:fluorflow/annotations.dart';
import 'package:fluorflow_generator/src/builder/router_builder.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  group('RouterBuilder', () {
    test(
        'should not generate something when no input is given.',
        () =>
            testBuilder(RouterBuilder(BuilderOptions.empty), {}, outputs: {}));

    test(
        'should not generate something when no injectable annotations are present.',
        () => testBuilder(RouterBuilder(BuilderOptions.empty), {
              'a|lib/a.dart': '''
                class View {}
              '''
            }, outputs: {}));

    group('for Routable()', () {
      test(
          'should generate route, pageBuilder, onGeneratedRoute, and extension methods for a route.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate custom route path.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable(path: '/fooBarBaz')
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/fooBarBaz');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not generate navigateTo extension if disabled.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable(navigateToExtension: false)
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not generate a replaceWith extension if disabled.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable(replaceWithExtension: false)
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not generate a rootTo extension if disabled.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable(rootToExtension: false)
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should use custom page route builder if provided.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';
                  import 'b.dart';

                  @Routable(routeBuilder: RouteBuilder.custom, pageRouteBuilder: CustomBuilder)
                  class View extends StatelessWidget {}
              ''',
                'a|lib/b.dart': '''
                import 'package:flutter/material.dart';

                class CustomBuilder extends PageRouteBuilder {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i4;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.CustomBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i4.generateRouteFactory(_pages);

extension RouteNavigation on _i4.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should throw when custom page is requested, but no page builder is provided.',
          () async {
        try {
          await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';
                  import 'b.dart';

                  @Routable(routeBuilder: RouteBuilder.custom)
                  class View extends StatelessWidget {}
              ''',
                'a|lib/b.dart': '''
                import 'package:flutter/material.dart';

                class CustomBuilder extends PageRouteBuilder {}
              '''
              },
              reader: await PackageAssetReader.currentIsolate());
          fail('Should have thrown');
        } catch (e) {
          expect(e, isA<InvalidGenerationSourceError>());
        }
      });

      for (final (transition, resultBuilder) in RouteBuilder.values
          .where((t) => t != RouteBuilder.custom)
          .map((t) => (t, '${t.name.pascalCase}PageRouteBuilder'))) {
        test(
            'should use correct page route builder '
            '($resultBuilder) for transition (${transition.name}).',
            () async => await testBuilder(
                RouterBuilder(BuilderOptions.empty),
                {
                  'a|lib/a.dart': '''
                    import 'package:fluorflow/annotations.dart';
                    import 'package:flutter/material.dart';

                    @Routable(routeBuilder: RouteBuilder.${transition.name})
                    class View extends StatelessWidget {}
                  ''',
                },
                outputs: {
                  'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.$resultBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
                },
                reader: await PackageAssetReader.currentIsolate()));
      }

      test(
          'should not generate route arguments for only "key" argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    const View({super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not generate route arguments for only "key" argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    const View({super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for a required positional argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String arg;
                    View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final String arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required String arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required String arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required String arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for a required nullable positional argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String? arg;
                    View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final String? arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required String? arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required String? arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required String? arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for an optional positional argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String arg;
                    View([this.arg = 'default']);
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({this.arg = 'default'});

  final String arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    String arg = 'default',
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    String arg = 'default',
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({String arg = 'default'}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for a required named argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String arg;
                    View({super.key, required this.arg});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(arg: args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final String arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required String arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required String arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required String arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for an optional named argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String? arg;
                    View({super.key, this.arg});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(arg: args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({this.arg});

  final String? arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    String? arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    String? arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({String? arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate route arguments for a defaulted named argument.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final String arg;
                    View({super.key, this.arg = 'default'});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(arg: args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({this.arg = 'default'});

  final String arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    String arg = 'default',
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    String arg = 'default',
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({String arg = 'default'}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate correct arguments for referenced arguments (custom).',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final Arg arg;
                    View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                  class Arg {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i4.Arg arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i4.Arg arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i4.Arg arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i4.Arg arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with Builder Configuration', () {
      test(
          'should use custom output if configured.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions({
                'output': 'lib/app/my.router.dart',
              })),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {}
              '''
              },
              outputs: {
                'a|lib/app/my.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            const _i3.View(),
      )
};
final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({bool preventDuplicates = true}) => navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void replaceWithView({bool preventDuplicates = true}) => replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
      );
  void rootToView() => rootTo(AppRoute.view.path);
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with special view argument types', () {
      test(
          'should generate arguments for generic list with primitive type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final List<int> arg;
                    const View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final List<int> arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required List<int> arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required List<int> arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required List<int> arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for generic list with complex type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  class Foobar {}

                  @Routable()
                  class View extends StatelessWidget {
                    final List<Foobar> arg;
                    const View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final List<_i3.Foobar> arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required List<_i3.Foobar> arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required List<_i3.Foobar> arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required List<_i3.Foobar> arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for record type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  class Foobar {}

                  @Routable()
                  class View extends StatelessWidget {
                    final (Foobar, int, {String name, Foobar f}) arg;
                    const View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final (_i3.Foobar, int, {_i3.Foobar f, String name}) arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required (_i3.Foobar, int, {_i3.Foobar f, String name}) arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required (_i3.Foobar, int, {_i3.Foobar f, String name}) arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView(
          {required (_i3.Foobar, int, {_i3.Foobar f, String name}) arg}) =>
      rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for nullable record type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  class Foobar {}

                  @Routable()
                  class View extends StatelessWidget {
                    final (Foobar, int)? arg;
                    const View({super.key, this.arg});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(arg: args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({this.arg});

  final (_i3.Foobar, int)? arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    (_i3.Foobar, int)? arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    (_i3.Foobar, int)? arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({(_i3.Foobar, int)? arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for recursive generic type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  class Foo<T> {}
                  class Bar<T, T2> {}

                  @Routable()
                  class View extends StatelessWidget {
                    final Foo<Bar<Baz, int>> arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i3.Foo<_i3.Bar<_i4.Baz, int>> arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i3.Foo<_i3.Bar<_i4.Baz, int>> arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i3.Foo<_i3.Bar<_i4.Baz, int>> arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i3.Foo<_i3.Bar<_i4.Baz, int>> arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for aliased import type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart' as b;

                  class Foo<T> {}

                  @Routable()
                  class View extends StatelessWidget {
                    final Foo<b.Baz> arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i3.Foo<_i4.Baz> arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i3.Foo<_i4.Baz> arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i3.Foo<_i4.Baz> arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i3.Foo<_i4.Baz> arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for function type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final void Function() arg;
                    const View(this.arg, {super.key});
                  }
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final void Function() arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required void Function() arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required void Function() arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required void Function() arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for complex function type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  class Foo {}
                  
                  class Bar<T> {}

                  @Routable()
                  class View extends StatelessWidget {
                    final Foo Function(Bar<Baz> i) arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i3.Foo Function(_i3.Bar<_i4.Baz>) arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i3.Foo Function(_i3.Bar<_i4.Baz>) arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i3.Foo Function(_i3.Bar<_i4.Baz>) arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i3.Foo Function(_i3.Bar<_i4.Baz>) arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for complex function with named parameters type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  class Foo {}
                  
                  class Bar<T> {}

                  @Routable()
                  class View extends StatelessWidget {
                    final Foo Function(Bar<Baz> i, { required Foo f, Baz? b }) arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i3.Foo Function(
    _i3.Bar<_i4.Baz>, {
    required _i3.Foo f,
    _i4.Baz? b,
  }) arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, {
      required _i3.Foo f,
      _i4.Baz? b,
    }) arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, {
      required _i3.Foo f,
      _i4.Baz? b,
    }) arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView(
          {required _i3.Foo Function(
            _i3.Bar<_i4.Baz>, {
            required _i3.Foo f,
            _i4.Baz? b,
          }) arg}) =>
      rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for complex function with optional parameters type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  class Foo {}
                  
                  class Bar<T> {}

                  @Routable()
                  class View extends StatelessWidget {
                    final Foo Function(Bar<Baz> i, [Foo? f]) arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i3.Foo Function(
    _i3.Bar<_i4.Baz>, [
    _i3.Foo?,
  ]) arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, [
      _i3.Foo?,
    ]) arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, [
      _i3.Foo?,
    ]) arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView(
          {required _i3.Foo Function(
            _i3.Bar<_i4.Baz>, [
            _i3.Foo?,
          ]) arg}) =>
      rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for aliased type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final MyCallback arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                class Foobar {}

                typedef MyCallback = void Function(Foobar);
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i4.MyCallback arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i4.MyCallback arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i4.MyCallback arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i4.MyCallback arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for aliased tuple type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final MyTuple arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                import 'c.dart';

                typedef MyTuple = (int, Foobar);
              ''',
                'a|lib/c.dart': '''
                class Foobar {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i4.MyTuple arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i4.MyTuple arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i4.MyTuple arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i4.MyTuple arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate arguments for aliased record type.',
          () async => await testBuilder(
              RouterBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                  import 'package:fluorflow/annotations.dart';
                  import 'package:flutter/material.dart';

                  import 'b.dart';

                  @Routable()
                  class View extends StatelessWidget {
                    final MyRecord arg;
                    const View(this.arg, {super.key});
                  }
              ''',
                'a|lib/b.dart': '''
                import 'c.dart';

                typedef MyRecord = ({int age, Foobar foo});
              ''',
                'a|lib/c.dart': '''
                class Foobar {}
              '''
              },
              outputs: {
                'a|lib/app.router.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:flutter/widgets.dart' as _i1;

enum AppRoute {
  view('/view');

  const AppRoute(this.path);

  final String path;
}

final _pages = <String, _i1.RouteFactory>{
  AppRoute.view.path: (data) => _i2.NoTransitionPageRouteBuilder(
        settings: data,
        pageBuilder: (
          _,
          __,
          ___,
        ) {
          final args = (data.arguments as ViewArguments);
          return _i3.View(args.arg);
        },
      )
};

class ViewArguments {
  const ViewArguments({required this.arg});

  final _i4.MyRecord arg;
}

final onGenerateRoute = _i2.generateRouteFactory(_pages);

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToView<T>({
    required _i4.MyRecord arg,
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void replaceWithView({
    required _i4.MyRecord arg,
    bool preventDuplicates = true,
  }) =>
      replaceWith(
        AppRoute.view.path,
        preventDuplicates: preventDuplicates,
        arguments: ViewArguments(arg: arg),
      );
  void rootToView({required _i4.MyRecord arg}) => rootTo(
        AppRoute.view.path,
        arguments: ViewArguments(arg: arg),
      );
}
''',
              },
              reader: await PackageAssetReader.currentIsolate()));
    });
  });
}
