import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/locator.dart';

import 'async_singleton.dart';

@Singleton()
class SingletonService {}

@Singleton(dependencies: [SingletonService, AsyncSingletonService])
class SingletonWithDependenciesService {
  final svc = locator<SingletonService>();
  final asyncSvc = locator<AsyncSingletonService>();
}
