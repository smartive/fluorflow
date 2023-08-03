import 'package:fluorflow/annotations.dart';
import 'package:fluorflow/fluorflow.dart';

import 'async_singleton.dart';

@Singleton()
class SingletonService {}

@Singleton(dependencies: [AsyncSingletonService])
class SingletonWithDependenciesService {
  final svc = locator<SingletonService>();
  final asyncSvc = locator<AsyncSingletonService>();
}
