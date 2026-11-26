import 'package:flashcards/core/database/app_database.dart';
import 'package:flashcards/core/database/app_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

ProviderContainer createContainer(AppDatabase database) {
  return ProviderContainer(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
  );
}

/// Material app hosting [child] with the test database injected.
Widget testApp(Widget child, AppDatabase database) {
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
    child: MaterialApp(home: child),
  );
}

/// Router based app used for screens that navigate.
Widget testRouterApp(GoRouter router, AppDatabase database) {
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
    child: MaterialApp.router(routerConfig: router),
  );
}

/// Pumps [app] and gives Drift's real async queries time to complete.
Future<void> pumpApp(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(app);
  await settleApp(tester);
}

/// Advances real async work, then the fake clock used by animations.
Future<void> settleApp(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 100)),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 450));
  await tester.pump(const Duration(milliseconds: 450));
}

/// Unmounts the tree and drains pending timers so the test ends cleanly.
Future<void> disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 50)),
  );
  await tester.pump(const Duration(seconds: 6));
  await tester.pump();
}
