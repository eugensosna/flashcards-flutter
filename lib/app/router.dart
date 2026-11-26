import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/decks/presentation/screens/deck_detail_screen.dart';
import '../features/decks/presentation/screens/deck_editor_screen.dart';
import '../features/decks/presentation/screens/deck_list_screen.dart';
import '../features/flashcards/presentation/screens/flashcard_editor_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/study/presentation/screens/statistics_screen.dart';
import '../features/study/presentation/screens/study_session_screen.dart';
import '../shared/widgets/app_shell.dart';
import '../shared/widgets/empty_state.dart';
import 'app_routes.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

int _deckId(GoRouterState state) =>
    int.tryParse(state.pathParameters['deckId'] ?? '') ?? 0;

int? _cardId(GoRouterState state) =>
    int.tryParse(state.pathParameters['cardId'] ?? '');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(),
      body: EmptyState(
        icon: Icons.explore_off_outlined,
        title: 'Page not found',
        message: 'There is nothing at ${state.uri}.',
        actionLabel: 'Go to dashboard',
        onAction: () => context.goNamed(AppRoutes.dashboard),
      ),
    ),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: AppRoutes.dashboard,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/decks',
                name: AppRoutes.decks,
                builder: (context, state) => const DeckListScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    name: AppRoutes.deckCreate,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const DeckEditorScreen(),
                  ),
                  GoRoute(
                    path: ':deckId',
                    name: AppRoutes.deckDetail,
                    builder: (context, state) =>
                        DeckDetailScreen(deckId: _deckId(state)),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        name: AppRoutes.deckEdit,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            DeckEditorScreen(deckId: _deckId(state)),
                      ),
                      GoRoute(
                        path: 'study',
                        name: AppRoutes.deckStudy,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            StudySessionScreen(deckId: _deckId(state)),
                      ),
                      GoRoute(
                        path: 'cards/new',
                        name: AppRoutes.cardCreate,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            FlashcardEditorScreen(deckId: _deckId(state)),
                      ),
                      GoRoute(
                        path: 'cards/:cardId/edit',
                        name: AppRoutes.cardEdit,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => FlashcardEditorScreen(
                          deckId: _deckId(state),
                          cardId: _cardId(state),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/statistics',
                name: AppRoutes.statistics,
                builder: (context, state) => const StatisticsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
