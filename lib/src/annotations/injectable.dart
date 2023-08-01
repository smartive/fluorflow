final class Singleton {
  final Iterable<Type>? dependencies;

  const Singleton({this.dependencies});
}

final class AsyncSingleton<T> {
  final Future<T> Function() factory;
  final Iterable<Type>? dependencies;

  const AsyncSingleton({required this.factory, this.dependencies});
}

final class LazySingleton {
  const LazySingleton();
}

final class Factory {
  const Factory();
}
