// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/services/demo.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

Future<void> setupLocator() async {
  _i1.locator.registerLazySingleton(() => _i2.DemoService());
  _i1.locator.registerLazySingleton(() => _i1.NavigationService());
  _i1.locator.registerLazySingleton(() => _i1.DialogService());
  await _i1.locator.allReady();
}
