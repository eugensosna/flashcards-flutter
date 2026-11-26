import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/repositories/drift_study_repository.dart';
import '../../domain/entities/review_rating.dart';
import '../../domain/entities/study_card.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/entities/study_statistics.dart';
import '../../domain/repositories/study_repository.dart';
import '../../domain/usecases/review_card_usecase.dart';
import '../../domain/usecases/start_study_session_usecase.dart';

part 'study_providers.g.dart';

@Riverpod(keepAlive: true)
StudyRepository studyRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return DriftStudyRepository(
    database: database,
    studyDao: database.studyDao,
    statsDao: database.statsDao,
  );
}

@Riverpod(keepAlive: true)
StartStudySession startStudySession(Ref ref) {
  return StartStudySession(ref.watch(studyRepositoryProvider));
}

@Riverpod(keepAlive: true)
LoadPracticeSession loadPracticeSession(Ref ref) {
  return LoadPracticeSession(ref.watch(studyRepositoryProvider));
}

@Riverpod(keepAlive: true)
ReviewCard reviewCard(Ref ref) {
  return ReviewCard(ref.watch(studyRepositoryProvider));
}

@riverpod
Stream<StudyStatistics> studyStatistics(Ref ref) {
  return ref.watch(studyRepositoryProvider).watchStatistics();
}

/// Reactive list of cards that are due right now, used for countdowns.
@riverpod
Stream<List<StudyCard>> dueFlashcards(Ref ref, int deckId) {
  return ref.watch(studyRepositoryProvider).watchDueFlashcards(deckId: deckId);
}

/// Drives an interactive study session for a single deck.
@riverpod
class StudySessionController extends _$StudySessionController {
  @override
  Future<StudySession> build(int deckId) async {
    final cards = await ref.watch(startStudySessionProvider)(deckId);
    return StudySession(deckId: deckId, cards: cards);
  }

  void flip() {
    final session = state.value;
    if (session == null || session.isFinished) {
      return;
    }
    state = AsyncData(session.copyWith(isFlipped: !session.isFlipped));
  }

  void next() {
    final session = state.value;
    if (session == null || !session.canGoForward) {
      return;
    }
    state = AsyncData(
      session.copyWith(
        currentIndex: session.currentIndex + 1,
        isFlipped: false,
      ),
    );
  }

  void previous() {
    final session = state.value;
    if (session == null || !session.canGoBack) {
      return;
    }
    state = AsyncData(
      session.copyWith(
        currentIndex: session.currentIndex - 1,
        isFlipped: false,
      ),
    );
  }

  /// Persists the rating through SM-2 and advances to the next card.
  ///
  /// Errors are rethrown so the screen can show a message without losing the
  /// session state.
  Future<void> rate(ReviewRating rating) async {
    final session = state.value;
    final card = session?.currentCard;
    if (session == null || card == null) {
      return;
    }

    await ref.read(reviewCardProvider)(card: card, rating: rating);

    state = AsyncData(
      session.copyWith(
        currentIndex: session.currentIndex + 1,
        isFlipped: false,
        reviewedCount: session.reviewedCount + 1,
      ),
    );
  }

  /// Loads every card of the deck, ignoring due dates.
  Future<void> practiceAll() async {
    final session = state.value;
    if (session == null) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final cards = await ref.read(loadPracticeSessionProvider)(session.deckId);
      return StudySession(deckId: session.deckId, cards: cards);
    });
  }

  void restart() => ref.invalidateSelf();
}
