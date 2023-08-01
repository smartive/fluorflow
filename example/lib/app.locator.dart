// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/locator.dart' as _i1;
import 'package:example/services/factory.dart' as _i2;
import 'package:example/services/singleton.dart' as _i3;
import 'package:example/services/async_singleton.dart' as _i4;
import 'package:example/services/lazy_singleton.dart' as _i5;

Future<void> setupLocator() async {
  _i1.locator.registerFactory(() => _i2.constructedSvcFactory());
  _i1.locator
      .registerFactoryParam<_i2.ConstructedServiceWithOneParam, String, void>((
    p1,
    _,
  ) =>
          _i2.constructedSvc1PFactory(p1));
  _i1.locator.registerFactoryParam<_i2.ConstructedServiceWithTwoParams, String,
      _i3.SingletonService>((
    p1,
    p2,
  ) =>
      _i2.constructedSvc2PFactory(
        p1,
        p2,
      ));
  _i1.locator.registerSingletonAsync(_i4.AsyncSingletonService.create);
  _i1.locator.registerSingletonAsync(_i4.createService);
  _i1.locator.registerSingletonAsync(
    _i4.AsyncSingletonWithDependencies.create,
    dependsOn: [_i4.AsyncSingletonService],
  );
  _i1.locator.registerLazySingleton(() => _i5.LazySingletonService());
  _i1.locator.registerSingleton(_i3.SingletonService());
  _i1.locator.registerSingletonWithDependencies(
    () => _i3.SingletonWithDependenciesService(),
    dependsOn: [
      _i3.SingletonService,
      _i4.AsyncSingletonService,
    ],
  );
  await _i1.locator.allReady();
}

extension Factories on _i1.Locator {
  _i2.ConstructedServiceWithOneParam getConstructedServiceWithOneParam(
          String name) =>
      get(param1: name);
  _i2.ConstructedServiceWithTwoParams getConstructedServiceWithTwoParams(
    String name,
    _i3.SingletonService svc,
  ) =>
      get(
        param1: name,
        param2: svc,
      );
}
