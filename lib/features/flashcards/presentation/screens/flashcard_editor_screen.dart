import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../decks/presentation/providers/deck_providers.dart';
import '../../domain/entities/flashcard.dart';
import '../providers/flashcard_providers.dart';

class FlashcardEditorScreen extends ConsumerWidget {
  const FlashcardEditorScreen({super.key, required this.deckId, this.cardId});

  final int deckId;

  /// `null` when creating a new card.
  final int? cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.watch(deckByIdProvider(deckId));
    final title = cardId == null ? 'New card' : 'Edit card';

    if (deck.value == null && deck.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (deck.hasError) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ErrorStateView(error: deck.error!),
      );
    }
    if (deck.value == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: EmptyState(
          icon: Icons.search_off,
          title: 'Deck not found',
          message: 'The deck for this card no longer exists.',
          actionLabel: 'Back to decks',
          onAction: () => context.goNamed(AppRoutes.decks),
        ),
      );
    }

    final id = cardId;
    if (id == null) {
      return _FlashcardForm(deckId: deckId, deckName: deck.value!.name);
    }

    final card = ref.watch(flashcardForEditingProvider(id));
    return card.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ErrorStateView(error: error),
      ),
      data: (value) {
        if (value == null) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Card not found',
              message: 'This flashcard may have been deleted.',
              actionLabel: 'Back to deck',
              onAction: () => context.goNamed(
                AppRoutes.deckDetail,
                pathParameters: {'deckId': '$deckId'},
              ),
            ),
          );
        }
        return _FlashcardForm(
          deckId: deckId,
          deckName: deck.value!.name,
          card: value,
        );
      },
    );
  }
}

class _FlashcardForm extends ConsumerStatefulWidget {
  const _FlashcardForm({
    required this.deckId,
    required this.deckName,
    this.card,
  });

  final int deckId;
  final String deckName;
  final Flashcard? card;

  @override
  ConsumerState<_FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends ConsumerState<_FlashcardForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _frontController = TextEditingController(
    text: widget.card?.front ?? '',
  );
  late final TextEditingController _backController = TextEditingController(
    text: widget.card?.back ?? '',
  );
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
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

    final card = await ref
        .read(flashcardEditorControllerProvider.notifier)
        .save(
          cardId: widget.card?.id,
          deckId: widget.deckId,
          front: _frontController.text,
          back: _backController.text,
        );

    if (!mounted) {
      return;
    }
    if (card == null) {
      final state = ref.read(flashcardEditorControllerProvider);
      setState(() {
        _isSaving = false;
        _errorMessage = state.when(
          data: (_) => 'The card could not be saved.',
          loading: () => 'The card could not be saved.',
          error: (error, _) => error is AppException
              ? error.message
              : 'The card could not be saved.',
        );
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.card == null ? 'Card added.' : 'Card updated.'),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.card != null;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isEditing ? 'Edit card' : 'New card'),
            Text(
              widget.deckName,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _frontController,
              decoration: const InputDecoration(
                labelText: 'Front',
                hintText: 'The question or prompt',
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: 6,
              validator: (value) =>
                  Validators.cardContent(value, label: 'front'),
              textInputAction: TextInputAction.next,
              autofocus: !isEditing,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _backController,
              decoration: const InputDecoration(
                labelText: 'Back',
                hintText: 'The answer',
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: 8,
              validator: (value) =>
                  Validators.cardContent(value, label: 'back'),
            ),
            if (widget.card != null && widget.card!.isArchived) ...[
              const SizedBox(height: 16),
              const _HintBanner(
                message:
                    'This card is archived. Unarchive it from the deck view to '
                    'include it in study sessions.',
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              _HintBanner(message: _errorMessage!, isError: true),
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
              label: Text(isEditing ? 'Save changes' : 'Add card'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HintBanner extends StatelessWidget {
  const _HintBanner({required this.message, this.isError = false});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final background = isError
        ? colors.errorContainer
        : colors.secondaryContainer;
    final foreground = isError
        ? colors.onErrorContainer
        : colors.onSecondaryContainer;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.info_outline,
            size: 20,
            color: foreground,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: TextStyle(color: foreground)),
          ),
        ],
      ),
    );
  }
}
