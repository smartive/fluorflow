# FluorFlow

FluorFlow is a dart / flutter package for
[MVVM UI architecture](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel).
It is heavily inspired by [Stacked](https://pub.dev/packages/stacked).

## Getting started

After adding the package to your `pubspec.yaml` file, you can start using it by
modifying your `main.dart` file as follows:

```dart
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluorFlow Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // This is the important part for routing
      initialRoute: AppRoute.homeView.path,
      onGenerateRoute: onGenerateRoute,
      navigatorKey: NavigationService.navigatorKey,
      navigatorObservers: [NavigationService.observer()],
    );
  }
}
```

Especially the part for routing is important (if you use FluorFlow views and routing):

```dart
initialRoute: AppRoute.homeView.path,
onGenerateRoute: onGenerateRoute,
navigatorKey: NavigationService.navigatorKey,
navigatorObservers: [NavigationService.observer()],
```

This enables the routing system of FluorFlow (which uses GetX underneath).

The other parts of the material app can be as you wish.

## Views

Creating views with view models has the advantage that you can separate the business logic
from the presentation of the view itself. This makes the code more readable and maintainable.
Further, you can just test your view models without the need of a UI test.
If UI testing is still needed, you can just fire up the whole view and test the UI anyway.
However, most of the time the business logic is the most important part of the app and should
be tested well.

To create a view with a view model, you can use the following example code:

```dart
final class HomeViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  var _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void goToDetail() => _navService.navigateToDetailView();
}

@Routable()
final class HomeView extends FluorFlowView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: const Text('Show Dialog'),
        ),
      );

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
```

The `@Routable` annotation is important for the routing system of FluorFlow. It is used to
generate the `AppRoute` enum and create extension methods on the `NavigationService`.

## Dependency Injection

FluorFlow uses the [get_it](https://pub.dev/packages/get_it) package for dependency injection.
In combination with the FluorFlow generator, you can easily inject your dependencies in a
`setupLocator` method and use them in your app.

The following example assumes that you use the `fluorflow_generator` (with `build_runner`)
to generate the `app.locator.dart` file.

```dart
// service.dart

@LazySingleton()
class Service {
    // implementation
}

// main.dart
import 'app.locator.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}
```

In your app, you can then use the provided locator via:

```dart
import 'package:fluorflow/fluorflow.dart';

final svc = locator<Service>();
//...
```

There are several possible types of injection:

- Singleton
- LazySingleton
- AsyncSingleton
- Factory (with up to two parameters)
- CustomLocatorFunction (for custom injection and functions)

## Dialogs / Bottom Sheets

A bottom sheet can be created with or without a view model.
The simple variant just defaults to a internal `NoopViewModel` that has no
further methods attached.

An example of a bottom sheet is:

```dart
final class GreetingBottomSheet extends FluorFlowSimpleBottomSheet<void> {
  const GreetingBottomSheet({super.key, required super.completer});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber[200],
        appBar: AppBar(
          title: const Text('Bottom Sheet'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('A Bottom Sheet'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: completer.confirm,
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
}
```

Bottom sheets are shown via the `BottomSheetService` that has extension methods
attached for each bottom sheet. Parameters of sheets are taken into account
when used with the fluorflow generator.

Dialogs work exactly the same way as bottom sheets, but are shown via the
`DialogService` and have another base class.

**Important:** Bottom sheets are always wrapped in a `Scaffold` widget. Thus,
they inherit your styles. `Dialogs` do not have this behavior (by design).
So you may create a full screen dialog and wrap it in a `Scaffold`, or
if you want a small "modal dialog" that has a backdrop and is dismissible
on click of the backdrop, it is also possible. However, you need
to wrap some parts of the content into a `Material` (or Theme provider)
widget to provide some decent default styles. Otherwise, some styles
are weird (e.g. Text Styles are big, red, and underlined).
You can see this in the examples (`SmallDialog`).

## CLI

FluorFlow comes with a CLI that can be used to generate views and other things.
Use `dart run fluorflow` to see the available commands.

To change configuration of the CLI (especially the biased options of the generator),
use the `fluorflow` key in your `pubspec.yaml` file.

```yaml
fluorflow:
  view_directory: lib/my_views
  test_view_directory: test/my_views
```

Defaults are:

- `view_directory`: `lib/ui/views`
- `test_view_directory`: `test/ui/views`
