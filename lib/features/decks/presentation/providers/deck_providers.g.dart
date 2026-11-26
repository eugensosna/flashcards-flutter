// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deckRepository)
final deckRepositoryProvider = DeckRepositoryProvider._();

final class DeckRepositoryProvider
    extends $FunctionalProvider<DeckRepository, DeckRepository, DeckRepository>
    with $Provider<DeckRepository> {
  DeckRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeckRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeckRepository create(Ref ref) {
    return deckRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeckRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeckRepository>(value),
    );
  }
}

String _$deckRepositoryHash() => r'a00a564aac5d225df91c248c1766266d15c09d2f';

@ProviderFor(createDeckUseCase)
final createDeckUseCaseProvider = CreateDeckUseCaseProvider._();

final class CreateDeckUseCaseProvider
    extends $FunctionalProvider<CreateDeck, CreateDeck, CreateDeck>
    with $Provider<CreateDeck> {
  CreateDeckUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createDeckUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createDeckUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateDeck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateDeck create(Ref ref) {
    return createDeckUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateDeck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateDeck>(value),
    );
  }
}

String _$createDeckUseCaseHash() => r'0b85972c09659a811d96706878ef8904a3dc097c';

@ProviderFor(updateDeckUseCase)
final updateDeckUseCaseProvider = UpdateDeckUseCaseProvider._();

final class UpdateDeckUseCaseProvider
    extends $FunctionalProvider<UpdateDeck, UpdateDeck, UpdateDeck>
    with $Provider<UpdateDeck> {
  UpdateDeckUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDeckUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateDeckUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateDeck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateDeck create(Ref ref) {
    return updateDeckUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateDeck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateDeck>(value),
    );
  }
}

String _$updateDeckUseCaseHash() => r'c468375ab6c24d0123f0d3d8cb38c0202e91ec49';

@ProviderFor(deleteDeckUseCase)
final deleteDeckUseCaseProvider = DeleteDeckUseCaseProvider._();

final class DeleteDeckUseCaseProvider
    extends $FunctionalProvider<DeleteDeck, DeleteDeck, DeleteDeck>
    with $Provider<DeleteDeck> {
  DeleteDeckUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteDeckUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteDeckUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteDeck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteDeck create(Ref ref) {
    return deleteDeckUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteDeck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteDeck>(value),
    );
  }
}

String _$deleteDeckUseCaseHash() => r'51e5fd8620b1d695292286ec56fce3d9c7f08fc7';

@ProviderFor(DeckSortController)
final deckSortControllerProvider = DeckSortControllerProvider._();

final class DeckSortControllerProvider
    extends $NotifierProvider<DeckSortController, DeckSort> {
  DeckSortControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckSortControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckSortControllerHash();

  @$internal
  @override
  DeckSortController create() => DeckSortController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeckSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeckSort>(value),
    );
  }
}

String _$deckSortControllerHash() =>
    r'f9b993577c1757b8e790170b9d96f500f5d96e25';

abstract class _$DeckSortController extends $Notifier<DeckSort> {
  DeckSort build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DeckSort, DeckSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeckSort, DeckSort>,
              DeckSort,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(DeckSearchController)
final deckSearchControllerProvider = DeckSearchControllerProvider._();

final class DeckSearchControllerProvider
    extends $NotifierProvider<DeckSearchController, String> {
  DeckSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckSearchControllerHash();

  @$internal
  @override
  DeckSearchController create() => DeckSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$deckSearchControllerHash() =>
    r'2ba4efafbe4b81cd5130dda30c616b478f94e5fb';

abstract class _$DeckSearchController extends $Notifier<String> {
  String build();
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
    return element.handleCreate(ref, build);
  }
}

/// Reactive list of decks, filtered and sorted by the controllers above.

@ProviderFor(deckList)
final deckListProvider = DeckListProvider._();

/// Reactive list of decks, filtered and sorted by the controllers above.

final class DeckListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeckSummary>>,
          List<DeckSummary>,
          Stream<List<DeckSummary>>
        >
    with
        $FutureModifier<List<DeckSummary>>,
        $StreamProvider<List<DeckSummary>> {
  /// Reactive list of decks, filtered and sorted by the controllers above.
  DeckListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckListHash();

  @$internal
  @override
  $StreamProviderElement<List<DeckSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DeckSummary>> create(Ref ref) {
    return deckList(ref);
  }
}

String _$deckListHash() => r'2dc933db85bf23ca0f5fade4c4ceb7d90b7888c3';

@ProviderFor(recentDecks)
final recentDecksProvider = RecentDecksProvider._();

final class RecentDecksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeckSummary>>,
          List<DeckSummary>,
          Stream<List<DeckSummary>>
        >
    with
        $FutureModifier<List<DeckSummary>>,
        $StreamProvider<List<DeckSummary>> {
  RecentDecksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentDecksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentDecksHash();

  @$internal
  @override
  $StreamProviderElement<List<DeckSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DeckSummary>> create(Ref ref) {
    return recentDecks(ref);
  }
}

String _$recentDecksHash() => r'aea845b211fbd7e5af5b59f5dab42119e99f533c';

@ProviderFor(deckDetails)
final deckDetailsProvider = DeckDetailsFamily._();

final class DeckDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeckSummary?>,
          DeckSummary?,
          Stream<DeckSummary?>
        >
    with $FutureModifier<DeckSummary?>, $StreamProvider<DeckSummary?> {
  DeckDetailsProvider._({
    required DeckDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'deckDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckDetailsHash();

  @override
  String toString() {
    return r'deckDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<DeckSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<DeckSummary?> create(Ref ref) {
    final argument = this.argument as int;
    return deckDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckDetailsHash() => r'4dc3c267c2ee18da2d76022e43521cebc8428bde';

final class DeckDetailsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DeckSummary?>, int> {
  DeckDetailsFamily._()
    : super(
        retry: null,
        name: r'deckDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckDetailsProvider call(int deckId) =>
      DeckDetailsProvider._(argument: deckId, from: this);

  @override
  String toString() => r'deckDetailsProvider';
}

@ProviderFor(deckById)
final deckByIdProvider = DeckByIdFamily._();

final class DeckByIdProvider
    extends $FunctionalProvider<AsyncValue<Deck?>, Deck?, FutureOr<Deck?>>
    with $FutureModifier<Deck?>, $FutureProvider<Deck?> {
  DeckByIdProvider._({
    required DeckByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'deckByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckByIdHash();

  @override
  String toString() {
    return r'deckByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Deck?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Deck?> create(Ref ref) {
    final argument = this.argument as int;
    return deckById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckByIdHash() => r'dfb48a68a930c6846b0d0faf08dd8dd02dbdee6d';

final class DeckByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Deck?>, int> {
  DeckByIdFamily._()
    : super(
        retry: null,
        name: r'deckByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckByIdProvider call(int deckId) =>
      DeckByIdProvider._(argument: deckId, from: this);

  @override
  String toString() => r'deckByIdProvider';
}

/// All decks as a one-shot future, used by pickers and dialogs.

@ProviderFor(allDecks)
final allDecksProvider = AllDecksProvider._();

/// All decks as a one-shot future, used by pickers and dialogs.

final class AllDecksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Deck>>,
          List<Deck>,
          FutureOr<List<Deck>>
        >
    with $FutureModifier<List<Deck>>, $FutureProvider<List<Deck>> {
  /// All decks as a one-shot future, used by pickers and dialogs.
  AllDecksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allDecksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allDecksHash();

  @$internal
  @override
  $FutureProviderElement<List<Deck>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Deck>> create(Ref ref) {
    return allDecks(ref);
  }
}

String _$allDecksHash() => r'0c6275b9143e8efd0bb7693c569f9c712c8482dc';

/// Handles create/edit submissions and exposes their async state.

@ProviderFor(DeckEditorController)
final deckEditorControllerProvider = DeckEditorControllerProvider._();

/// Handles create/edit submissions and exposes their async state.
final class DeckEditorControllerProvider
    extends $AsyncNotifierProvider<DeckEditorController, void> {
  /// Handles create/edit submissions and exposes their async state.
  DeckEditorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckEditorControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckEditorControllerHash();

  @$internal
  @override
  DeckEditorController create() => DeckEditorController();
}

String _$deckEditorControllerHash() =>
    r'cc9acc7ee95367235f7b6be1937aec06a8ee86cd';

/// Handles create/edit submissions and exposes their async state.

abstract class _$DeckEditorController extends $AsyncNotifier<void> {
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

/// Destructive deck operations, kept separate from form state.

@ProviderFor(DeckActionsController)
final deckActionsControllerProvider = DeckActionsControllerProvider._();

/// Destructive deck operations, kept separate from form state.
final class DeckActionsControllerProvider
    extends $AsyncNotifierProvider<DeckActionsController, void> {
  /// Destructive deck operations, kept separate from form state.
  DeckActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckActionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckActionsControllerHash();

  @$internal
  @override
  DeckActionsController create() => DeckActionsController();
}

String _$deckActionsControllerHash() =>
    r'd9e4733440c91afd3f8a7de9c45b0b394fef987b';

/// Destructive deck operations, kept separate from form state.

abstract class _$DeckActionsController extends $AsyncNotifier<void> {
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
