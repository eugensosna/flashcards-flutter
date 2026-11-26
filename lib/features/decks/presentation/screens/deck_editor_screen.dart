import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../domain/entities/deck.dart';
import '../providers/deck_providers.dart';

class DeckEditorScreen extends ConsumerWidget {
  const DeckEditorScreen({super.key, this.deckId});

  /// `null` when creating a new deck.
  final int? deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = deckId;
    if (id == null) {
      return const _DeckForm();
    }

    final deck = ref.watch(deckByIdProvider(id));
    return deck.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Edit deck')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Edit deck')),
        body: ErrorStateView(error: error),
      ),
      data: (value) {
        if (value == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Edit deck')),
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Deck not found',
              message: 'This deck may have been deleted.',
              actionLabel: 'Back to decks',
              onAction: () => context.goNamed(AppRoutes.decks),
            ),
          );
        }
        return _DeckForm(deck: value);
      },
    );
  }
}

class _DeckForm extends ConsumerStatefulWidget {
  const _DeckForm({this.deck});

  final Deck? deck;

  @override
  ConsumerState<_DeckForm> createState() => _DeckFormState();
}

class _DeckFormState extends ConsumerState<_DeckForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController = TextEditingController(
    text: widget.deck?.name ?? '',
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.deck?.description ?? '');
  late String? _color = widget.deck?.color;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    final deck = await ref
        .read(deckEditorControllerProvider.notifier)
        .save(
          deckId: widget.deck?.id,
          name: _nameController.text,
          description: _descriptionController.text,
          color: _color,
        );

    if (!mounted) {
      return;
    }
    if (deck == null) {
      final state = ref.read(deckEditorControllerProvider);
      setState(() {
        _isSaving = false;
        _errorMessage = state.when(
          data: (_) => 'The deck could not be saved.',
          loading: () => 'The deck could not be saved.',
          error: (error, _) => error is AppException
              ? error.message
              : 'The deck could not be saved.',
        );
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.deck == null ? 'Deck created.' : 'Deck updated.'),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.deck != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit deck' : 'New deck')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Deck name',
                hintText: 'e.g. Spanish vocabulary',
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.deckName,
              autofocus: !isEditing,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'What is this deck about?',
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            Text('Color', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final color in AppColors.deckPalette)
                  _ColorOption(
                    color: color,
                    isSelected: _color == AppColors.toHex(color),
                    onTap: () =>
                        setState(() => _color = AppColors.toHex(color)),
                  ),
              ],
            ),
            if (_color != null) ...[
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () => setState(() => _color = null),
                icon: const Icon(Icons.format_color_reset_outlined),
                label: const Text('No color'),
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              _ErrorBanner(message: _errorMessage!),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSaving ? null : _save,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              label: Text(isEditing ? 'Save changes' : 'Create deck'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  const _ColorOption({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Deck color',
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 2.5,
                  )
                : null,
          ),
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : null,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 20, color: colors.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colors.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
