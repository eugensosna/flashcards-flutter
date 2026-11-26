// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studyRepository)
final studyRepositoryProvider = StudyRepositoryProvider._();

final class StudyRepositoryProvider
    extends
        $FunctionalProvider<StudyRepository, StudyRepository, StudyRepository>
    with $Provider<StudyRepository> {
  StudyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyRepositoryHash();

  @$internal
  @override
  $ProviderElement<StudyRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StudyRepository create(Ref ref) {
    return studyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudyRepository>(value),
    );
  }
}

String _$studyRepositoryHash() => r'f38d1e4e64a97c9f073d9b85a54512f23455f9c6';

@ProviderFor(startStudySession)
final startStudySessionProvider = StartStudySessionProvider._();

final class StartStudySessionProvider
    extends
        $FunctionalProvider<
          StartStudySession,
          StartStudySession,
          StartStudySession
        >
    with $Provider<StartStudySession> {
  StartStudySessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startStudySessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startStudySessionHash();

  @$internal
  @override
  $ProviderElement<StartStudySession> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StartStudySession create(Ref ref) {
    return startStudySession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StartStudySession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StartStudySession>(value),
    );
  }
}

String _$startStudySessionHash() => r'52e20f7f7e08cf65e9eace2c1c63cafabb4c0603';

@ProviderFor(loadPracticeSession)
final loadPracticeSessionProvider = LoadPracticeSessionProvider._();

final class LoadPracticeSessionProvider
    extends
        $FunctionalProvider<
          LoadPracticeSession,
          LoadPracticeSession,
          LoadPracticeSession
        >
    with $Provider<LoadPracticeSession> {
  LoadPracticeSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadPracticeSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadPracticeSessionHash();

  @$internal
  @override
  $ProviderElement<LoadPracticeSession> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoadPracticeSession create(Ref ref) {
    return loadPracticeSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadPracticeSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadPracticeSession>(value),
    );
  }
}

String _$loadPracticeSessionHash() =>
    r'90faa257be33d752d9d7bea12ff5c1d82bf033d0';

@ProviderFor(reviewCard)
final reviewCardProvider = ReviewCardProvider._();

final class ReviewCardProvider
    extends $FunctionalProvider<ReviewCard, ReviewCard, ReviewCard>
    with $Provider<ReviewCard> {
  ReviewCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewCardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewCardHash();

  @$internal
  @override
  $ProviderElement<ReviewCard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReviewCard create(Ref ref) {
    return reviewCard(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewCard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewCard>(value),
    );
  }
}

String _$reviewCardHash() => r'4aae22cdc53b7627e27d68117e9426319ee6e482';

@ProviderFor(studyStatistics)
final studyStatisticsProvider = StudyStatisticsProvider._();

final class StudyStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<StudyStatistics>,
          StudyStatistics,
          Stream<StudyStatistics>
        >
    with $FutureModifier<StudyStatistics>, $StreamProvider<StudyStatistics> {
  StudyStatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyStatisticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyStatisticsHash();

  @$internal
  @override
  $StreamProviderElement<StudyStatistics> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<StudyStatistics> create(Ref ref) {
    return studyStatistics(ref);
  }
}

String _$studyStatisticsHash() => r'6b7b0ad6d45bdd8193e1fdc2fe5c1708c41f6eb2';

/// Reactive list of cards that are due right now, used for countdowns.

@ProviderFor(dueFlashcards)
final dueFlashcardsProvider = DueFlashcardsFamily._();

/// Reactive list of cards that are due right now, used for countdowns.

final class DueFlashcardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StudyCard>>,
          List<StudyCard>,
          Stream<List<StudyCard>>
        >
    with $FutureModifier<List<StudyCard>>, $StreamProvider<List<StudyCard>> {
  /// Reactive list of cards that are due right now, used for countdowns.
  DueFlashcardsProvider._({
    required DueFlashcardsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'dueFlashcardsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dueFlashcardsHash();

  @override
  String toString() {
    return r'dueFlashcardsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<StudyCard>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<StudyCard>> create(Ref ref) {
    final argument = this.argument as int;
    return dueFlashcards(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DueFlashcardsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dueFlashcardsHash() => r'd47dc83a3d95997018f9f566e0b87c4d836ab983';

/// Reactive list of cards that are due right now, used for countdowns.

final class DueFlashcardsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<StudyCard>>, int> {
  DueFlashcardsFamily._()
    : super(
        retry: null,
        name: r'dueFlashcardsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Reactive list of cards that are due right now, used for countdowns.

  DueFlashcardsProvider call(int deckId) =>
      DueFlashcardsProvider._(argument: deckId, from: this);

  @override
  String toString() => r'dueFlashcardsProvider';
}

/// Drives an interactive study session for a single deck.

@ProviderFor(StudySessionController)
final studySessionControllerProvider = StudySessionControllerFamily._();

/// Drives an interactive study session for a single deck.
final class StudySessionControllerProvider
    extends $AsyncNotifierProvider<StudySessionController, StudySession> {
  /// Drives an interactive study session for a single deck.
  StudySessionControllerProvider._({
    required StudySessionControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'studySessionControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studySessionControllerHash();

  @override
  String toString() {
    return r'studySessionControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StudySessionController create() => StudySessionController();

  @override
  bool operator ==(Object other) {
    return other is StudySessionControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studySessionControllerHash() =>
    r'7c0a3b19d72935ee6ac524611f2bce8f8b43cd93';

/// Drives an interactive study session for a single deck.

final class StudySessionControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StudySessionController,
          AsyncValue<StudySession>,
          StudySession,
          FutureOr<StudySession>,
          int
        > {
  StudySessionControllerFamily._()
    : super(
        retry: null,
        name: r'studySessionControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Drives an interactive study session for a single deck.

  StudySessionControllerProvider call(int deckId) =>
      StudySessionControllerProvider._(argument: deckId, from: this);

  @override
  String toString() => r'studySessionControllerProvider';
}

/// Drives an interactive study session for a single deck.

abstract class _$StudySessionController extends $AsyncNotifier<StudySession> {
  late final _$args = ref.$arg as int;
  int get deckId => _$args;

  FutureOr<StudySession> build(int deckId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<StudySession>, StudySession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StudySession>, StudySession>,
              AsyncValue<StudySession>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
