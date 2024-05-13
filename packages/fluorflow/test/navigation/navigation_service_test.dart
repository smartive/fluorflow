import 'package:fluorflow/fluorflow.dart';
import 'package:fluorflow/src/navigation/navigation_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

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

Widget _app() {
  getRouteHistory(NavigationService.observer).clear();
  return routableMockApp(_routeFactory, '/one');
}

void main() {
  group('Navigation Service', () {
    testWidgets('should show initial route without navigation.',
        (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.byType(_ViewOne), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 1);
      expect(getRouteHistory(NavigationService.observer).first.settings.name,
          '/one');
    });

    testWidgets('should correctly navigate to page.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two');
      await tester.pumpAndSettle();

      expect(find.byType(_ViewTwo), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 2);
    });

    testWidgets('should return current route.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two');
      await tester.pumpAndSettle();

      expect(nav.currentRoute, '/two');
    });

    testWidgets('should return current arguments.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two', arguments: {'foo': 'bar'});
      await tester.pumpAndSettle();

      expect(nav.currentArguments['foo'], 'bar');
    });

    testWidgets('should correctly navigate back.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two');
      await tester.pumpAndSettle();
      nav.back();
      await tester.pumpAndSettle();

      expect(find.byType(_ViewOne), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 1);
      expect(getRouteHistory(NavigationService.observer).first.settings.name,
          '/one');
    });

    testWidgets('should replace route on stack.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two');
      await tester.pumpAndSettle();
      nav.replaceWith('/three');
      await tester.pumpAndSettle();

      expect(find.byType(_ViewThree), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 2);
      expect(nav.currentRoute, '/three');
    });

    testWidgets('should clear routes on root to.', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      const nav = NavigationService();
      nav.navigateTo('/two');
      nav.navigateTo('/three');
      await tester.pumpAndSettle();
      nav.rootTo('/one');
      await tester.pumpAndSettle();

      expect(find.byType(_ViewOne), findsOneWidget);
      expect(getRouteHistory(NavigationService.observer).length, 1);
      expect(nav.currentRoute, '/one');
    });
  });
}
