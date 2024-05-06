# Fluorflow Generator

This package contains the code generator for the fluorflow framework.

## Usage

Add the dart build runner to your project with `flutter pub add build_runner --dev`.
Then add the fluorflow generator with `flutter pub add fluorflow_generator --dev`.
(Or use the direct git config when not using a published version)

When the build runner is executed (`dart run build_runner build`), the code will be generated.

Examples for the usage of the generators can be found in the `fluorflow` package.

## Configuration

To configure the generator, use the technique of the "build_runner". In your `build.yaml` file,
you can use `global_options` or specific options for the generators.

Such a config file can look like this:

```yaml
# build.yaml
global_options:
  fluorflow_generator:locator:
    options:
      output: 'lib/app/app.locator.dart'

  fluorflow_generator:testLocator:
    options:
      output: 'test/helpers/test.locator.dart'

  fluorflow_generator:router:
    options:
      output: 'lib/app/app.router.dart'

  fluorflow_generator:dialog:
    options:
      output: 'lib/app/app.dialogs.dart'

  fluorflow_generator:bottomSheet:
    options:
      output: 'lib/app/app.bottom_sheets.dart'
```

### Locator Options

- `output` (String): The file path for the generated locator file. Default: `lib/app.locator.dart`.
- `emitAllReady` (bool): Whether to emit the `await allReady()` method call in the locator setup method. Default: `true`.
- `register_services`: Whether to register services in the locator.
  - `navigation` (bool): Whether to register the navigation service. Default: `true`.

### Test Locator Options

- `output` (String): The file path for the generated locator file. Default: `test/test.locator.dart`.
- `register_services`: Whether to register services in the locator.
  - `navigation` (bool): Whether to register the mock navigation service. Default: `true`.

### Router Options

- `output` (String): The file path for the generated file. Default: `lib/app.router.dart`.

### Dialog Options

- `output` (String): The file path for the generated file. Default: `lib/app.dialogs.dart`.

### Bottom Sheet Options

- `output` (String): The file path for the generated file. Default: `lib/app.bottom_sheets.dart`.

## Generators

Currently the following generators are supported:

- Dependency Injection (For services and test services)
- Routing
- Dialogs
- Bottom Sheets

### Dependency Injection

The generator for DI uses the "GetIt" library underneath. It generates the setup method
for the GetIt locator and the locator itself.

There are several annotations that enable dependency injection. Some of them are:

- Singleton / LazySingleton / AsyncSingleton
- Factory

Other annotations exist to configure the generated code.

The generator also creates mocks if you have the `mockito` package installed. Then it
will generate a setup method that sets up all mocked services to be used in tests.

### Routing

When using fluorflow views, the `@Routable` annotation will generate a route for the given view.
The path will be added to the `AppRoute` enum and an extension method is generated for the
`NavigationService` of fluorflow. So a given route (`@Routable class DetailView ...`) will generate the following
code:

```dart
enum AppRoute {
  detailView('/detail-view');

  const AppRoute(this.path);

  final String path;
}

// some other boilerplate

extension RouteNavigation on _i2.NavigationService {
  Future<T?>? navigateToDetailView<T>({
    bool preventDuplicates = true,
  }) =>
      navigateTo(
        AppRoute.detailView.path,
        preventDuplicates: preventDuplicates,
      );
}
```

The behavior of the generated extensions can be configured with the routable annotation.

### Dialogs / Bottom Sheets

Both of these work the same way. You just extend the `FluorFlowDialog`, `FluorFlowSimpleDialog`,
`FluorFlowBottomSheet` or `FluorFlowSimpleBottomSheet` classes. There are special annotations
for configuration of the generated code - if needed.

When such extended classes are found, method extensions for the `NavigationService` are generated.

An example of such a dialog method:

```dart
extension Dialogs on _i1.NavigationService {
  Future<(bool?, int?)> showMyDialog({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
  }) =>
      showDialog<(bool?, int?)>(
        barrierColor: barrierColor,
        dialogBuilder: _i1.NoTransitionPageRouteBuilder(
            pageBuilder: (
          _,
          __,
          ___,
        ) =>
                _i4.MyDialog(
                  completer: closeOverlay,
                )),
      ).then((r) => (r?.$1, r?.$2));
}
```

Refer to the documentation of the respective classes to see other examples and usage.
