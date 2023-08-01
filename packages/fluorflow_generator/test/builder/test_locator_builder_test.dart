import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:fluorflow_generator/src/builder/test_locator_builder.dart';
import 'package:test/test.dart';

void main() {
  group('TestLocatorBuilder', () {
    final noSvcs = BuilderOptions({
      'services': {'navigation': false, 'dialog': false, 'bottomSheet': false},
    });

    test('should not run when mockito is not installed.', () async {
      final logs = List<String>.empty(growable: true);

      await testBuilder(
          TestLocatorBuilder(BuilderOptions.empty),
          {
            'a|lib/a.dart': '''
                class View {}
              '''
          },
          outputs: {},
          reader: StubAssetReader(),
          onLog: (l) => logs.add(l.toString()));

      expect(
          logs,
          contains(
              '[INFO] testBuilder: Mockito is not installed, skipping builder.'));
    },
        skip:
            'This test does not work, since I dont know how to mock the packageConfig correctly.');

    test(
        'should not generate something when no input is given.',
        () => testBuilder(TestLocatorBuilder(BuilderOptions.empty), {},
            outputs: {}));

    test(
        'should generate the default for fluorflow services if no other serivces are given.',
        () async => await testBuilder(
            TestLocatorBuilder(BuilderOptions.empty),
            {
              'a|lib/a.dart': '''
                class View {}
              '''
            },
            outputs: {
              'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
            },
            reader: await PackageAssetReader.currentIsolate()));

    group('for Singletons', () {
      test(
          'should generate a mock for a class singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate a mock for a factory singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @Singleton()
                Svc getSvc() => Svc();
              ''',
                'a|lib/b.dart': '''
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate a mock for a class singleton in test directory.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|test/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @Singleton()
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'a.dart' as _i3;
import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for AsyncSingletons', () {
      test(
          'should generate a mock for a class singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @AsyncSingleton(factory: Svc.create)
                class Svc {
                  static Future<Svc> create() async => Svc();
                }
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate a mock for a factory singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @AsyncSingleton()
                Future<Svc> getSvc() async => Svc();
              ''',
                'a|lib/b.dart': '''
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for LazySingletons', () {
      test(
          'should generate a mock for a class singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @LazySingleton()
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate a mock for a factory singleton.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @LazySingleton()
                Svc getSvc() => Svc();
              ''',
                'a|lib/b.dart': '''
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerSingleton<_i3.Svc>(service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for Factories', () {
      test(
          'should generate a mock for a factory.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                import 'b.dart';

                @Factory()
                Svc getSvc() => Svc();
              ''',
                'a|lib/b.dart': '''
                class Svc {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i4;

import 'test.locator.mocks.dart' as _i1;

_i1.MockSvc getMockSvc() {
  if (_i2.locator.isRegistered<_i3.Svc>()) {
    _i2.locator.unregister<_i3.Svc>();
  }
  final service = _i1.MockSvc();
  _i2.locator.registerFactory<_i3.Svc>(() => service);
  return service;
}

@_i4.GenerateNiceMocks(
    [_i4.MockSpec<_i3.Svc>(onMissingStub: _i4.OnMissingStub.returnDefault)])
void setupTestLocator() {
  getMockSvc();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with Builder Config', () {
      test(
          'should use custom output if configured.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions({
                'output': 'test/helpers/test.locator.dart',
              })),
              {
                'a|lib/a.dart': '''
                class View {}
              '''
              },
              outputs: {
                'a|test/helpers/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not mock navigation service when disabled.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions({
                'services': {'navigation': false},
              })),
              {
                'a|lib/a.dart': '''
                class View {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not mock dialog service when disabled.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions({
                'services': {'dialog': false},
              })),
              {
                'a|lib/a.dart': '''
                class View {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should not mock buttom sheet service when disabled.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions({
                'services': {'bottomSheet': false},
              })),
              {
                'a|lib/a.dart': '''
                class View {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should still generate setup function if no services are registered at all.',
          () async => await testBuilder(
              TestLocatorBuilder(noSvcs),
              {
                'a|lib/a.dart': '''
                class View {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i1;

@_i1.GenerateNiceMocks([])
void setupTestLocator() {}
void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with IgnoreDependency', () {
      for (final ca in ['Singleton', 'LazySingleton', 'AsyncSingleton']) {
        test(
            'should ignore the dependency when annotation is present on $ca.',
            () async => await testBuilder(
                TestLocatorBuilder(BuilderOptions.empty),
                {
                  'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @$ca()
                @IgnoreDependency()
                class ServiceA {}
              '''
                },
                outputs: {
                  'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
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
                TestLocatorBuilder(BuilderOptions.empty),
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
                  'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
                },
                reader: await PackageAssetReader.currentIsolate()));
      }
    });

    group('for CustomLocatorFunctions', () {
      test(
          'should not include the custom function if not allowed to.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @CustomLocatorFunction(includeInTestLocator: false)
                void customFunc() {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should include the custom function.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @CustomLocatorFunction()
                void customFunc() {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a/a.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  _i4.customFunc();
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should include the custom function from test files.',
          () async => await testBuilder(
              TestLocatorBuilder(BuilderOptions.empty),
              {
                'a|test/a.dart': '''
                import 'package:fluorflow/annotations.dart';

                @CustomLocatorFunction()
                void customFunc() {}
              '''
              },
              outputs: {
                'a|test/test.locator.dart': '''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'a.dart' as _i4;
import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

_i1.MockDialogService getMockDialogService() {
  if (_i2.locator.isRegistered<_i2.DialogService>()) {
    _i2.locator.unregister<_i2.DialogService>();
  }
  final service = _i1.MockDialogService();
  _i2.locator.registerSingleton<_i2.DialogService>(service);
  return service;
}

_i1.MockBottomSheetService getMockBottomSheetService() {
  if (_i2.locator.isRegistered<_i2.BottomSheetService>()) {
    _i2.locator.unregister<_i2.BottomSheetService>();
  }
  final service = _i1.MockBottomSheetService();
  _i2.locator.registerSingleton<_i2.BottomSheetService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.DialogService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
  _i3.MockSpec<_i2.BottomSheetService>(
      onMissingStub: _i3.OnMissingStub.returnDefault),
])
void setupTestLocator() {
  _i4.customFunc();
  getMockNavigationService();
  getMockDialogService();
  getMockBottomSheetService();
}

void tearDownLocator() => _i2.locator.reset();
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });
  });
}
