import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:fluorflow_generator/src/builder/locator_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  group('LocatorBuilder', () {
    test(
        'should not generate something when no input is given.',
        () =>
            testBuilder(LocatorBuilder(BuilderOptions.empty), {}, outputs: {}));

    test(
        'should register the services when no other things are registered.',
        () => testBuilder(LocatorBuilder(BuilderOptions.empty), {
              'a|lib/a.dart': '''
                class Service {}
              '''
            }, outputs: {
              'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
            }));

    group('for Singletons', () {
      test(
          'should generate registration for a singleton service.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceA {}
              ''',
                'a|lib/sub/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceB {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:a/sub/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.ServiceA());
  _i1.locator.registerSingleton(_i3.ServiceB());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for a singleton service with dependencies.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'sub/b.dart';

                @Singleton(dependencies: [ServiceB])
                class ServiceA {}
              ''',
                'a|lib/sub/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceB {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:a/sub/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingletonWithDependencies(
    () => _i2.ServiceA(),
    dependsOn: [_i3.ServiceB],
  );
  _i1.locator.registerSingleton(_i3.ServiceB());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for a singleton service function.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {}

                @Singleton()
                Svc factory() => Svc();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.factory());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for a singleton service function with dependencies.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class SvcA {}

                class SvcB {}

                @Singleton(dependencies: [SvcA])
                SvcB factory() => SvcB();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.SvcA());
  _i1.locator.registerSingletonWithDependencies(
    () => _i2.factory(),
    dependsOn: [_i2.SvcA],
  );
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for LazySingletons', () {
      test(
          'should generate registration for a lazy singleton service.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @LazySingleton()
                class ServiceA {}
              ''',
                'a|lib/sub/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                @LazySingleton()
                class ServiceB {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:a/sub/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i2.ServiceA());
  _i1.locator.registerLazySingleton(() => _i3.ServiceB());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for a lazy singleton service function.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {}

                @LazySingleton()
                Svc factory() => Svc();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(_i2.factory);
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for AsyncSingletons', () {
      test(
          'should generate registration for an async singleton service.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @AsyncSingleton(factory: AsyncSingletonServiceA.create)
                class AsyncSingletonServiceA {
                  static Future<AsyncSingletonServiceA> create() async =>
                      AsyncSingletonServiceA();
                }
              ''',
                'a|lib/sub/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                @AsyncSingleton(factory: createService)
                class AsyncSingletonServiceB {}

                Future<AsyncSingletonServiceB> createService() async =>
                    AsyncSingletonServiceB();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:a/sub/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingletonAsync(_i2.AsyncSingletonServiceA.create);
  _i1.locator.registerSingletonAsync(_i3.createService);
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test('should throw when an async singleton on a class has no factory.',
          () async {
        try {
          await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';
        
                @AsyncSingleton()
                class Svc {}
              '''
              },
              reader: await PackageAssetReader.currentIsolate());
          fail('should throw');
        } catch (e) {
          expect(e, isA<InvalidGenerationSourceError>());
        }
      });

      test(
          'should generate registration for an async singleton service with dependencies.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'sub/b.dart';

                @AsyncSingleton(
                  factory: AsyncSingletonServiceA.create,
                  dependencies: [AsyncSingletonServiceB])
                class AsyncSingletonServiceA {
                  static Future<AsyncSingletonServiceA> create() async =>
                      AsyncSingletonServiceA();
                }
              ''',
                'a|lib/sub/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                @AsyncSingleton(factory: createService)
                class AsyncSingletonServiceB {}

                Future<AsyncSingletonServiceB> createService() async =>
                    AsyncSingletonServiceB();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:a/sub/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingletonAsync(
    _i2.AsyncSingletonServiceA.create,
    dependsOn: [_i3.AsyncSingletonServiceB],
  );
  _i1.locator.registerSingletonAsync(_i3.createService);
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for an async singleton service function.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {}

                @AsyncSingleton()
                Future<Svc> factory() async => Svc();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingletonAsync(_i2.factory);
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration for an async singleton service function with dependencies.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class SvcA {}

                class SvcB {}

                @AsyncSingleton(dependencies: [SvcA])
                Future<SvcB> factory() async => SvcB();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.SvcA());
  _i1.locator.registerSingletonAsync(
    _i2.factory,
    dependsOn: [_i2.SvcA],
  );
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for Factories', () {
      test(
          'should generate registration for a factory without params.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {}

                @Factory()
                Svc factory() => Svc();
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactory(() => _i2.factory());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
      test(
          'should generate registration for a factory without params and external return value.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @Factory()
                Svc factory() => Svc();
              ''',
                'a|lib/b.dart': '''
                class Svc {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactory(() => _i2.factory());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration and locator extension for factory with 1 param.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {
                  final String p1;
                  Svc(this.p1);
                }

                @Factory()
                Svc factory(String p1) => Svc(p1);
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactoryParam<_i2.Svc, String, void>((
    p1,
    _,
  ) =>
      _i2.factory(p1));
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}

extension Factories on _i1.Locator {
  _i2.Svc getSvc(String p1) => get(param1: p1);
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration and locator extension for factory with 1 param and external return value.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @Factory()
                Svc factory(String p1) => Svc(p1);
              ''',
                'a|lib/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Svc {
                  final String p1;
                  Svc(this.p1);
                }
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactoryParam<_i2.Svc, String, void>((
    p1,
    _,
  ) =>
      _i3.factory(p1));
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}

extension Factories on _i1.Locator {
  _i2.Svc getSvc(String p1) => get(param1: p1);
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration and locator extension for factory with 2 params.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Ref {}

                class Svc {
                  final String p1;
                  final Ref p2;
                  Svc(this.p1, this.p2);
                }

                @Factory()
                Svc factory(String p1, Ref p2) => Svc(p1, p2);
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactoryParam<_i2.Svc, String, _i2.Ref>((
    p1,
    p2,
  ) =>
      _i2.factory(
        p1,
        p2,
      ));
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}

extension Factories on _i1.Locator {
  _i2.Svc getSvc(
    String p1,
    _i2.Ref p2,
  ) =>
      get(
        param1: p1,
        param2: p2,
      );
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate registration and locator extension for factory with 2 params and external return value.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @Factory()
                Svc factory(String p1, Ref p2) => Svc(p1, p2);
              ''',
                'a|lib/b.dart': '''
                import 'package:fluorflow/annotations.dart';

                class Ref {}

                class Svc {
                  final String p1;
                  final Ref p2;
                  Svc(this.p1, this.p2);
                }
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerFactoryParam<_i2.Svc, String, _i2.Ref>((
    p1,
    p2,
  ) =>
      _i3.factory(
        p1,
        p2,
      ));
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}

extension Factories on _i1.Locator {
  _i2.Svc getSvc(
    String p1,
    _i2.Ref p2,
  ) =>
      get(
        param1: p1,
        param2: p2,
      );
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test('should throw when factory method is private.', () async {
        try {
          await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';
        
                class Svc {}
        
                @Factory()
                Svc _factory() => Svc();
              '''
              },
              reader: await PackageAssetReader.currentIsolate());
          fail('should throw');
        } catch (e) {
          expect(e, isA<InvalidGenerationSourceError>());
        }
      });

      test('should throw when factory method has more than 2 params.',
          () async {
        try {
          await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';
        
                class Svc {}
        
                @Factory()
                Svc _factory(String p1, String p2, String p3) => Svc();
              '''
              },
              reader: await PackageAssetReader.currentIsolate());
          fail('should throw');
        } catch (e) {
          expect(e, isA<InvalidGenerationSourceError>());
        }
      });
    });

    group('with IgnoreDependency', () {
      for (final ca in ['Singleton', 'LazySingleton', 'AsyncSingleton']) {
        test(
            'should ignore the dependency when annotation is present on $ca.',
            () async => await testBuilder(
                LocatorBuilder(BuilderOptions.empty),
                {
                  'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @$ca()
                @IgnoreDependency()
                class ServiceA {}
              '''
                },
                outputs: {
                  'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
                },
                reader: await PackageAssetReader.currentIsolate()));
      }

      for (final ca in [
        'Singleton',
        'LazySingleton',
        'AsyncSingleton',
        'Factory'
      ]) {
        test(
            'should ignore the dependency factory when annotation is present on $ca.',
            () async => await testBuilder(
                LocatorBuilder(BuilderOptions.empty),
                {
                  'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                class ServiceA {}

                @$ca()
                @IgnoreDependency()
                ServiceA factory() => ServiceA();
              '''
                },
                outputs: {
                  'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
                },
                reader: await PackageAssetReader.currentIsolate()));
      }
    });

    group('for CustomLocatorFunctions', () {
      test(
          'should not include the custom function if not allowed to.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @CustomLocatorFunction(includeInLocator: false)
                void customFunc() {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should include the custom function.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @CustomLocatorFunction()
                void customFunc() {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i1;
import 'package:fluorflow/fluorflow.dart' as _i2;

Future<void> setupLocator() async {
  _i1.customFunc();
  _i2.locator.registerLazySingleton(() => _i2.NavigationService());
  await _i2.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with Builder Configuration', () {
      test(
          'should not generate something when no services are registered and all default services are disabled.',
          () => testBuilder(
                  LocatorBuilder(BuilderOptions({
                    'register_services': {
                      'navigation': false,
                      'dialog': false,
                      'bottomSheet': false
                    }
                  })),
                  {
                    'a|lib/a.dart': '''
                class Service {}
              '''
                  },
                  outputs: {}));

      test(
          'should not emit allReady when configured.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions({
                'emitAllReady': false,
              })),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceA {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.ServiceA());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should use custom output if configured.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions({
                'output': 'lib/app/my.locator.dart',
              })),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceA {}
              '''
              },
              outputs: {
                'a|lib/app/my.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.ServiceA());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not register NavigationService when disabled.',
          () async => await testBuilder(
              LocatorBuilder(BuilderOptions({
                'register_services': {'navigation': false},
              })),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class ServiceA {}
              '''
              },
              outputs: {
                'a|lib/app.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerSingleton(_i2.ServiceA());
  await _i1.locator.allReady();
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });
  });
}
