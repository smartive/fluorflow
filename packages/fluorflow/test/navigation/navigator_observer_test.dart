import 'package:fluorflow/fluorflow.dart';
import 'package:fluorflow/src/navigation/navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _ViewOne extends StatelessWidget {
  const _ViewOne();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class _ViewTwo extends StatelessWidget {
  const _ViewTwo();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class _ViewThree extends StatelessWidget {
  const _ViewThree();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

RouteFactory _factory(Widget view) =>
    (settings) => NoTransitionPageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => view);

final _routeFactory = generateRouteFactory({
  '/one': _factory(const _ViewOne()),
  '/two': _factory(const _ViewTwo()),
  '/three': _factory(const _ViewThree()),
});

Widget _app(NavigatorObserver Function(FluorflowNavigatorObserver) mod) {
  getRouteHistory(NavigationService.observer).clear();
  return MaterialApp(
    navigatorKey: NavigationService.navigatorKey,
    navigatorObservers: [mod(NavigationService.observer)],
    onGenerateRoute: _routeFactory,
    initialRoute: '/one',
  );
}

void main() {
  group('Navigation Observer', () {
    testWidgets('should use default, non opinionated, options.',
        (tester) async {
      await tester.pumpWidget(_app((obs) => obs));
      await tester.pumpAndSettle();

      const nav = NavigationService();

      for (var i = 0; i < 30; i++) {
        nav.navigateTo('/two');
      }
      await tester.pumpAndSettle();

      expect(find.byType(_ViewTwo), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 31);
    });

    testWidgets('should respect maximal history limit (for back navigation).',
        (tester) async {
      await tester.pumpWidget(_app((obs) => obs..maxLength = 5));
      await tester.pumpAndSettle();

      const nav = NavigationService();

      for (var i = 0; i < 30; i++) {
        nav.navigateTo('/two');
      }
      await tester.pumpAndSettle();

      expect(find.byType(_ViewTwo), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 5);
    });
  });
}
