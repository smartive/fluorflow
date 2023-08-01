// ignore_for_file: avoid_print

import 'package:fluorflow/annotations.dart';

@Singleton()
class DemoService {
  void doSomething() {
    print('Doing something');
  }
}

@LazySingleton()
class LazyDemoService {
  void doSomething() {
    print('Doing something');
  }
}

@AsyncSingleton(factory: AsyncDemoService.create)
class AsyncDemoService {
  static Future<AsyncDemoService> create() async {
    return AsyncDemoService();
  }

  void doSomething() {
    print('Doing something');
  }
}

@AsyncSingleton()
Future<AsyncFactoryDemoService> createAsyncFactoryDemoService() async {
  return AsyncFactoryDemoService();
}

class AsyncFactoryDemoService {}
