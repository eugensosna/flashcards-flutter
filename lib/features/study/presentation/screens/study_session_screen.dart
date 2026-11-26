import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state_view.dart';
import '../../../decks/presentation/providers/deck_providers.dart';
import '../../domain/entities/review_rating.dart';
import '../../domain/entities/study_session.dart';
import '../providers/study_providers.dart';
import '../widgets/flip_card.dart';

class StudySessionScreen extends ConsumerWidget {
  const StudySessionScreen({super.key, required this.deckId});

  final int deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(studySessionControllerProvider(deckId));
    final deck = ref.watch(deckDetailsProvider(deckId)).value;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Study'),
            if (deck != null)
              Text(
                deck.deck.name,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
      body: session.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorStateView(
          error: error,
          onRetry: () => ref.invalidate(studySessionControllerProvider(deckId)),
        ),
        data: (data) => _StudyBody(session: data, deckId: deckId),
      ),
    );
  }
}

class _StudyBody extends ConsumerWidget {
  const _StudyBody({required this.session, required this.deckId});

  final StudySession session;
  final int deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(
      studySessionControllerProvider(deckId).notifier,
    );

    if (session.isEmpty) {
      return EmptyState(
        icon: Icons.check_circle_outline,
        title: 'Nothing due right now',
        message:
            'All cards in this deck are scheduled for later. You can still '
            'practice every card.',
        actionLabel: 'Practice all cards',
        onAction: controller.practiceAll,
        secondaryActionLabel: 'Back to deck',
        onSecondaryAction: () => context.pop(),
      );
    }

    if (session.isFinished) {
      return _SessionSummary(
        reviewedCount: session.reviewedCount,
        total: session.total,
        onRestart: controller.restart,
      );
    }

    final card = session.currentCard!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: session.progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${session.currentIndex + 1}/${session.total}',
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                card.isNew ? 'New card' : 'Review',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: card.isNew
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                'Reviewed ${session.reviewedCount}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FlipCard(
              front: card.card.front,
              back: card.card.back,
              isFlipped: session.isFlipped,
              onTap: controller.flip,
              hint: session.isFlipped
                  ? 'Rate your recall below'
                  : 'Tap to reveal the answer',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton.filledTonal(
                tooltip: 'Previous card',
                onPressed: session.canGoBack ? controller.previous : null,
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: controller.flip,
                  icon: Icon(
                    session.isFlipped
                        ? Icons.flip_to_front
                        : Icons.flip_to_back,
                  ),
                  label: Text(
                    session.isFlipped ? 'Show question' : 'Show answer',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: 'Next card',
                onPressed: session.canGoForward ? controller.next : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (session.isFlipped)
            _RatingButtons(deckId: deckId)
          else
            Text(
              'Reveal the answer to rate this card.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

class _RatingButtons extends ConsumerStatefulWidget {
  const _RatingButtons({required this.deckId});

  final int deckId;

  @override
  ConsumerState<_RatingButtons> createState() => _RatingButtonsState();
}

class _RatingButtonsState extends ConsumerState<_RatingButtons> {
  bool _isSaving = false;

  Future<void> _rate(ReviewRating rating) async {
    if (_isSaving) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      await ref
          .read(studySessionControllerProvider(widget.deckId).notifier)
          .rate(rating);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error is AppException
                  ? error.message
                  : 'Could not save your review. Please try again.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final rating in ReviewRating.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _colorFor(rating),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 46),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  textStyle: const TextStyle(fontSize: 13),
                ),
                onPressed: _isSaving ? null : () => _rate(rating),
                child: Text(rating.label, maxLines: 1),
              ),
            ),
          ),
      ],
    );
  }

  Color _colorFor(ReviewRating rating) => switch (rating) {
    ReviewRating.again => AppColors.again,
    ReviewRating.hard => AppColors.hard,
    ReviewRating.good => AppColors.good,
    ReviewRating.easy => AppColors.easy,
  };
}

class _SessionSummary extends StatelessWidget {
  const _SessionSummary({
    required this.reviewedCount,
    required this.total,
    required this.onRestart,
  });

  final int reviewedCount;
  final int total;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.celebration_outlined,
              size: 56,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('Session complete', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'You reviewed $reviewedCount of $total '
              '${total == 1 ? 'card' : 'cards'}.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text('Study again'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Back to deck'),
            ),
          ],
        ),
      ),
    );
  }
}
