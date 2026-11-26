import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode =
        ref.watch(themeModeControllerProvider).value ?? AppThemeMode.system;
    final stats = ref.watch(dashboardStatsProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Appearance', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<AppThemeMode>(
                      showSelectedIcon: false,
                      segments: [
                        for (final mode in AppThemeMode.values)
                          ButtonSegment<AppThemeMode>(
                            value: mode,
                            label: Text(mode.label),
                          ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (selection) =>
                          _setTheme(context, ref, selection.first),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Data', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.storage_outlined),
                  title: const Text('Local database'),
                  subtitle: const Text(
                    'SQLite via Drift · schema '
                    'v${AppConstants.databaseSchemaVersion}',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.style_outlined),
                  title: const Text('Decks'),
                  trailing: Text(
                    '${stats?.totalDecks ?? 0}',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.copy_all_outlined),
                  title: const Text('Flashcards'),
                  trailing: Text(
                    '${stats?.totalFlashcards ?? 0}',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: theme.colorScheme.surfaceContainerHigh,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text('Offline first', style: theme.textTheme.titleSmall),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Decks, flashcards and study progress are stored only on '
                    'this device. Nothing is uploaded anywhere.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setTheme(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode mode,
  ) async {
    try {
      await ref.read(themeModeControllerProvider.notifier).setMode(mode);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The theme could not be saved.')),
        );
      }
    }
  }
}
