// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flashcardRepository)
final flashcardRepositoryProvider = FlashcardRepositoryProvider._();

final class FlashcardRepositoryProvider
    extends
        $FunctionalProvider<
          FlashcardRepository,
          FlashcardRepository,
          FlashcardRepository
        >
    with $Provider<FlashcardRepository> {
  FlashcardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashcardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashcardRepositoryHash();

  @$internal
  @override
  $ProviderElement<FlashcardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlashcardRepository create(Ref ref) {
    return flashcardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlashcardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlashcardRepository>(value),
    );
  }
}

String _$flashcardRepositoryHash() =>
    r'1e7232afb18278d3b5ca6f6825eafeb41323900c';

@ProviderFor(createFlashcardUseCase)
final createFlashcardUseCaseProvider = CreateFlashcardUseCaseProvider._();

final class CreateFlashcardUseCaseProvider
    extends
        $FunctionalProvider<CreateFlashcard, CreateFlashcard, CreateFlashcard>
    with $Provider<CreateFlashcard> {
  CreateFlashcardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createFlashcardUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createFlashcardUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateFlashcard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateFlashcard create(Ref ref) {
    return createFlashcardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateFlashcard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateFlashcard>(value),
    );
  }
}

String _$createFlashcardUseCaseHash() =>
    r'0d3789d5d1d9d2755a3766f0dd5aabea93206352';

@ProviderFor(updateFlashcardUseCase)
final updateFlashcardUseCaseProvider = UpdateFlashcardUseCaseProvider._();

final class UpdateFlashcardUseCaseProvider
    extends
        $FunctionalProvider<UpdateFlashcard, UpdateFlashcard, UpdateFlashcard>
    with $Provider<UpdateFlashcard> {
  UpdateFlashcardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateFlashcardUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateFlashcardUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateFlashcard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateFlashcard create(Ref ref) {
    return updateFlashcardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateFlashcard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateFlashcard>(value),
    );
  }
}

String _$updateFlashcardUseCaseHash() =>
    r'22df5fe7bf6d11ed45cefc1f114e8979948278f9';

@ProviderFor(deleteFlashcardUseCase)
final deleteFlashcardUseCaseProvider = DeleteFlashcardUseCaseProvider._();

final class DeleteFlashcardUseCaseProvider
    extends
        $FunctionalProvider<DeleteFlashcard, DeleteFlashcard, DeleteFlashcard>
    with $Provider<DeleteFlashcard> {
  DeleteFlashcardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteFlashcardUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteFlashcardUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteFlashcard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteFlashcard create(Ref ref) {
    return deleteFlashcardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteFlashcard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteFlashcard>(value),
    );
  }
}

String _$deleteFlashcardUseCaseHash() =>
    r'94aaeb5ccc1ecc332997c183bb35e3b1b2bb8a4e';

@ProviderFor(moveFlashcardUseCase)
final moveFlashcardUseCaseProvider = MoveFlashcardUseCaseProvider._();

final class MoveFlashcardUseCaseProvider
    extends $FunctionalProvider<MoveFlashcard, MoveFlashcard, MoveFlashcard>
    with $Provider<MoveFlashcard> {
  MoveFlashcardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moveFlashcardUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moveFlashcardUseCaseHash();

  @$internal
  @override
  $ProviderElement<MoveFlashcard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MoveFlashcard create(Ref ref) {
    return moveFlashcardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MoveFlashcard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MoveFlashcard>(value),
    );
  }
}

String _$moveFlashcardUseCaseHash() =>
    r'5e8861c6cd6ca52adbcb810cf926c9b3bc9c9724';

@ProviderFor(archiveFlashcardUseCase)
final archiveFlashcardUseCaseProvider = ArchiveFlashcardUseCaseProvider._();

final class ArchiveFlashcardUseCaseProvider
    extends
        $FunctionalProvider<
          ArchiveFlashcard,
          ArchiveFlashcard,
          ArchiveFlashcard
        >
    with $Provider<ArchiveFlashcard> {
  ArchiveFlashcardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archiveFlashcardUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archiveFlashcardUseCaseHash();

  @$internal
  @override
  $ProviderElement<ArchiveFlashcard> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArchiveFlashcard create(Ref ref) {
    return archiveFlashcardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArchiveFlashcard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArchiveFlashcard>(value),
    );
  }
}

String _$archiveFlashcardUseCaseHash() =>
    r'3fa581088cc8683f10342d153b659c1e1762cda0';

@ProviderFor(reorderFlashcardsUseCase)
final reorderFlashcardsUseCaseProvider = ReorderFlashcardsUseCaseProvider._();

final class ReorderFlashcardsUseCaseProvider
    extends
        $FunctionalProvider<
          ReorderFlashcards,
          ReorderFlashcards,
          ReorderFlashcards
        >
    with $Provider<ReorderFlashcards> {
  ReorderFlashcardsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reorderFlashcardsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reorderFlashcardsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ReorderFlashcards> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReorderFlashcards create(Ref ref) {
    return reorderFlashcardsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReorderFlashcards value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReorderFlashcards>(value),
    );
  }
}

String _$reorderFlashcardsUseCaseHash() =>
    r'3c68f93ad634cfc94c472b37bbcb4e2b852efbbc';

@ProviderFor(FlashcardSearchController)
final flashcardSearchControllerProvider = FlashcardSearchControllerFamily._();

final class FlashcardSearchControllerProvider
    extends $NotifierProvider<FlashcardSearchController, String> {
  FlashcardSearchControllerProvider._({
    required FlashcardSearchControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'flashcardSearchControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flashcardSearchControllerHash();

  @override
  String toString() {
    return r'flashcardSearchControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FlashcardSearchController create() => FlashcardSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardSearchControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flashcardSearchControllerHash() =>
    r'0e32dacd1cb3abc3aeadcfb959072bd965d10b0c';

final class FlashcardSearchControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          FlashcardSearchController,
          String,
          String,
          String,
          int
        > {
  FlashcardSearchControllerFamily._()
    : super(
        retry: null,
        name: r'flashcardSearchControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlashcardSearchControllerProvider call(int deckId) =>
      FlashcardSearchControllerProvider._(argument: deckId, from: this);

  @override
  String toString() => r'flashcardSearchControllerProvider';
}

abstract class _$FlashcardSearchController extends $Notifier<String> {
  late final _$args = ref.$arg as int;
  int get deckId => _$args;

  String build(int deckId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ArchivedFilterController)
final archivedFilterControllerProvider = ArchivedFilterControllerFamily._();

final class ArchivedFilterControllerProvider
    extends $NotifierProvider<ArchivedFilterController, bool> {
  ArchivedFilterControllerProvider._({
    required ArchivedFilterControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'archivedFilterControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$archivedFilterControllerHash();

  @override
  String toString() {
    return r'archivedFilterControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArchivedFilterController create() => ArchivedFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ArchivedFilterControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$archivedFilterControllerHash() =>
    r'854d5b54cc68c5d3b01046e9ff20b6c42f5f4b74';

final class ArchivedFilterControllerFamily extends $Family
    with $ClassFamilyOverride<ArchivedFilterController, bool, bool, bool, int> {
  ArchivedFilterControllerFamily._()
    : super(
        retry: null,
        name: r'archivedFilterControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArchivedFilterControllerProvider call(int deckId) =>
      ArchivedFilterControllerProvider._(argument: deckId, from: this);

  @override
  String toString() => r'archivedFilterControllerProvider';
}

abstract class _$ArchivedFilterController extends $Notifier<bool> {
  late final _$args = ref.$arg as int;
  int get deckId => _$args;

  bool build(int deckId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(flashcardsByDeck)
final flashcardsByDeckProvider = FlashcardsByDeckFamily._();

final class FlashcardsByDeckProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Flashcard>>,
          List<Flashcard>,
          Stream<List<Flashcard>>
        >
    with $FutureModifier<List<Flashcard>>, $StreamProvider<List<Flashcard>> {
  FlashcardsByDeckProvider._({
    required FlashcardsByDeckFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'flashcardsByDeckProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flashcardsByDeckHash();

  @override
  String toString() {
    return r'flashcardsByDeckProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Flashcard>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Flashcard>> create(Ref ref) {
    final argument = this.argument as int;
    return flashcardsByDeck(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardsByDeckProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flashcardsByDeckHash() => r'abba1cfb41876eb5cf3ac367cb676a0895d5561d';

final class FlashcardsByDeckFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Flashcard>>, int> {
  FlashcardsByDeckFamily._()
    : super(
        retry: null,
        name: r'flashcardsByDeckProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlashcardsByDeckProvider call(int deckId) =>
      FlashcardsByDeckProvider._(argument: deckId, from: this);

  @override
  String toString() => r'flashcardsByDeckProvider';
}

@ProviderFor(flashcardById)
final flashcardByIdProvider = FlashcardByIdFamily._();

final class FlashcardByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Flashcard?>,
          Flashcard?,
          Stream<Flashcard?>
        >
    with $FutureModifier<Flashcard?>, $StreamProvider<Flashcard?> {
  FlashcardByIdProvider._({
    required FlashcardByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'flashcardByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flashcardByIdHash();

  @override
  String toString() {
    return r'flashcardByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Flashcard?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Flashcard?> create(Ref ref) {
    final argument = this.argument as int;
    return flashcardById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flashcardByIdHash() => r'54a040002ef6e655cb25a1e079510cb88d552803';

final class FlashcardByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Flashcard?>, int> {
  FlashcardByIdFamily._()
    : super(
        retry: null,
        name: r'flashcardByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlashcardByIdProvider call(int cardId) =>
      FlashcardByIdProvider._(argument: cardId, from: this);

  @override
  String toString() => r'flashcardByIdProvider';
}

@ProviderFor(flashcardForEditing)
final flashcardForEditingProvider = FlashcardForEditingFamily._();

final class FlashcardForEditingProvider
    extends
        $FunctionalProvider<
          AsyncValue<Flashcard?>,
          Flashcard?,
          FutureOr<Flashcard?>
        >
    with $FutureModifier<Flashcard?>, $FutureProvider<Flashcard?> {
  FlashcardForEditingProvider._({
    required FlashcardForEditingFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'flashcardForEditingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flashcardForEditingHash();

  @override
  String toString() {
    return r'flashcardForEditingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Flashcard?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Flashcard?> create(Ref ref) {
    final argument = this.argument as int;
    return flashcardForEditing(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardForEditingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flashcardForEditingHash() =>
    r'4a58612a4f0bab1639e094523fd0d2dd65b99f0b';

final class FlashcardForEditingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Flashcard?>, int> {
  FlashcardForEditingFamily._()
    : super(
        retry: null,
        name: r'flashcardForEditingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlashcardForEditingProvider call(int cardId) =>
      FlashcardForEditingProvider._(argument: cardId, from: this);

  @override
  String toString() => r'flashcardForEditingProvider';
}

@ProviderFor(FlashcardEditorController)
final flashcardEditorControllerProvider = FlashcardEditorControllerProvider._();

final class FlashcardEditorControllerProvider
    extends $AsyncNotifierProvider<FlashcardEditorController, void> {
  FlashcardEditorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashcardEditorControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashcardEditorControllerHash();

  @$internal
  @override
  FlashcardEditorController create() => FlashcardEditorController();
}

String _$flashcardEditorControllerHash() =>
    r'a6f8c8b4606905f1cb4aeb1310ca000be16a6742';

abstract class _$FlashcardEditorController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Delete, archive, move and reorder operations for a card list.

@ProviderFor(FlashcardActionsController)
final flashcardActionsControllerProvider =
    FlashcardActionsControllerProvider._();

/// Delete, archive, move and reorder operations for a card list.
final class FlashcardActionsControllerProvider
    extends $AsyncNotifierProvider<FlashcardActionsController, void> {
  /// Delete, archive, move and reorder operations for a card list.
  FlashcardActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashcardActionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashcardActionsControllerHash();

  @$internal
  @override
  FlashcardActionsController create() => FlashcardActionsController();
}

String _$flashcardActionsControllerHash() =>
    r'2ef6e7b2f9e1813bc356b287eb6b735033b587a2';

/// Delete, archive, move and reorder operations for a card list.

abstract class _$FlashcardActionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
