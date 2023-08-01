/// A class decorator that marks a class as a singleton.
///
/// Singletons have only one instance throughout the application.
///
/// The [dependencies] parameter is an optional iterable of types that the singleton
/// depends on. These dependencies will be automatically resolved and injected
/// when the singleton is instantiated.
///
/// Example usage:
/// ```dart
/// @Singleton(dependencies: [Database])
/// class UserRepository {
///   // ...
/// }
/// ```
class Singleton {
  final Iterable<Type>? dependencies;

  const Singleton({this.dependencies});
}

/// Represents an asynchronously created singleton instance.
///
/// It may contain a factory function that returns a [Future] of the singleton instance.
/// The factory function is invoked only once, and the result is cached for subsequent invocations.
///
/// The [AsyncSingleton] can also specify a list of dependencies that are required for creating the singleton instance.
/// These dependencies can be other types or classes that need to be instantiated before the singleton can be created.
///
/// When used on a class, the [factory] param must point to a static method or a top level function that
/// creates the instance of the singleton.
///
/// Example on a class:
/// ```dart
/// @AsyncSingleton(factory: AsyncDemoService.create)
/// class AsyncDemoService {
///   static Future<AsyncDemoService> create() async {
///     return AsyncDemoService();
///   }
/// }
/// ```
///
/// Example as a top level function:
/// ```dart
/// @AsyncSingleton()
/// Future<AsyncFactoryDemoService> createAsyncFactoryDemoService() async {
///   return AsyncFactoryDemoService();
/// }
///
/// class AsyncFactoryDemoService {}
/// ```
class AsyncSingleton<T> {
  final Future<T> Function()? factory;
  final Iterable<Type>? dependencies;

  const AsyncSingleton({this.factory, this.dependencies});
}

/// Annotation used to mark a class as a lazy singleton.
///
/// A lazy singleton is a class that is instantiated only once and its
/// instance is lazily created when it is first accessed.
///
/// Usage:
/// ```
/// @LazySingleton()
/// class MyClass {
///   // class implementation
/// }
/// ```
///
/// Note: When this annotation is used, dependencies are automatically resolved and injected.
final class LazySingleton {
  const LazySingleton();
}

/// Annotation used to mark a function as a dependency factory.
///
/// Factories are used in dependency injection to create instances of a dependency every
/// time they are called. This is sometimes referenced as "transient" or "non-singleton" instances.
///
/// When using a factory, a method extension on the `Locator` is generated to provide an
/// easy way to call the factory method.
///
/// Example usage:
///
/// ```dart
/// @Factory()
/// MyService createMyService() => MyService();
///
/// class MyService {
///   // class implementation
/// }
/// ```
///
/// Because of a design decision of the underlying dependency injection library, factories
/// can have a maximum of 2 parameters. If you need more parameters, consider using an object
/// as parameter.
final class Factory {
  const Factory();
}

/// Annotation used to indicate that a dependency should be ignored by the dependency injection system.
///
/// The [IgnoreDependency] annotation can be applied to a class/factory to specify that it should
/// not be included in the dependency injection container.
/// By default, the dependency is ignored in both the production and test dependency injection containers.
/// The [inLocator] and [inTestLocator] parameters can be used to control whether
/// the dependency should be included in the production and test dependency injection containers respectively.
///
/// Example usage:
/// ```dart
/// @IgnoreDependency(inLocator: false)
/// class MyService {
///   // ...
/// }
/// ```
class IgnoreDependency {
  final bool inLocator;
  final bool inTestLocator;

  const IgnoreDependency({this.inLocator = true, this.inTestLocator = true});
}

/// An annotation used to mark a function as a custom locator function.
///
/// This function is directly passed to the locator in the setup function.
final class CustomLocatorFunction {
  final bool includeInLocator;
  final bool includeInTestLocator;

  const CustomLocatorFunction(
      {this.includeInLocator = true, this.includeInTestLocator = true});
}
