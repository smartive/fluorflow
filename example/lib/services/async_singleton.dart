import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/locator.dart';

@AsyncSingleton(factory: AsyncSingletonService.create)
class AsyncSingletonService {
  static Future<AsyncSingletonService> create() async =>
      AsyncSingletonService();
}

@AsyncSingleton(factory: createService)
class AnotherAsyncSingletonService {}

Future<AnotherAsyncSingletonService> createService() async =>
    AnotherAsyncSingletonService();

@AsyncSingleton(
    factory: AsyncSingletonWithDependencies.create,
    dependencies: [AsyncSingletonService])
class AsyncSingletonWithDependencies {
  final svc = locator<AsyncSingletonService>();

  static Future<AsyncSingletonWithDependencies> create() async =>
      AsyncSingletonWithDependencies();
}
