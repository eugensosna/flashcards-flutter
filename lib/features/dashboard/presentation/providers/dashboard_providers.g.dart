// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider = DashboardRepositoryProvider._();

final class DashboardRepositoryProvider
    extends
        $FunctionalProvider<
          DashboardRepository,
          DashboardRepository,
          DashboardRepository
        >
    with $Provider<DashboardRepository> {
  DashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRepository create(Ref ref) {
    return dashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRepository>(value),
    );
  }
}

String _$dashboardRepositoryHash() =>
    r'5f977bb4764ad82a4c792b66db6f7c0f50336b0a';

@ProviderFor(dashboardStats)
final dashboardStatsProvider = DashboardStatsProvider._();

final class DashboardStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardStats>,
          DashboardStats,
          Stream<DashboardStats>
        >
    with $FutureModifier<DashboardStats>, $StreamProvider<DashboardStats> {
  DashboardStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardStatsHash();

  @$internal
  @override
  $StreamProviderElement<DashboardStats> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<DashboardStats> create(Ref ref) {
    return dashboardStats(ref);
  }
}

String _$dashboardStatsHash() => r'25129e6e2ad0cd2bfd2d384fa2eaea62cadd703d';

/// The deck with the most cards due, used by the dashboard quick action.

@ProviderFor(nextStudyDeck)
final nextStudyDeckProvider = NextStudyDeckProvider._();

/// The deck with the most cards due, used by the dashboard quick action.

final class NextStudyDeckProvider
    extends $FunctionalProvider<DeckSummary?, DeckSummary?, DeckSummary?>
    with $Provider<DeckSummary?> {
  /// The deck with the most cards due, used by the dashboard quick action.
  NextStudyDeckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextStudyDeckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextStudyDeckHash();

  @$internal
  @override
  $ProviderElement<DeckSummary?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeckSummary? create(Ref ref) {
    return nextStudyDeck(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeckSummary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeckSummary?>(value),
    );
  }
}

String _$nextStudyDeckHash() => r'06d7d23a9e73eb01bb90c202cd43aebdf460c7f6';
