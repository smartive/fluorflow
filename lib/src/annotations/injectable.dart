final class Singleton {
  final Iterable<Type>? dependencies;

  const Singleton({this.dependencies});
}

final class AsyncSingleton<T> {
  final Future<T> Function()? factory;
  final Iterable<Type>? dependencies;

  const AsyncSingleton({this.factory, this.dependencies});
}

final class LazySingleton {
  const LazySingleton();
}

final class Factory {
  const Factory();
}

final class IgnoreDependency {
  final bool inLocator;
  final bool inTestLocator;

  const IgnoreDependency({this.inLocator = true, this.inTestLocator = true});
}

final class CustomLocatorFunction {
  final bool includeInLocator;
  final bool includeInTestLocator;

  const CustomLocatorFunction(
      {this.includeInLocator = true, this.includeInTestLocator = true});
}
