// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardStats {

 int get totalDecks; int get totalFlashcards; int get dueCards; int get studiedToday; List<DeckSummary> get recentDecks;
/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<DashboardStats> get copyWith => _$DashboardStatsCopyWithImpl<DashboardStats>(this as DashboardStats, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DashboardStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStats&&(identical(other.totalDecks, _this.totalDecks) || other.totalDecks == _this.totalDecks)&&(identical(other.totalFlashcards, _this.totalFlashcards) || other.totalFlashcards == _this.totalFlashcards)&&(identical(other.dueCards, _this.dueCards) || other.dueCards == _this.dueCards)&&(identical(other.studiedToday, _this.studiedToday) || other.studiedToday == _this.studiedToday)&&const DeepCollectionEquality().equals(other.recentDecks, _this.recentDecks));
}


@override
int get hashCode {
  final _this = this as DashboardStats;
  return Object.hash(runtimeType,_this.totalDecks,_this.totalFlashcards,_this.dueCards,_this.studiedToday,const DeepCollectionEquality().hash(_this.recentDecks));
}

@override
String toString() {
  final _this = this as DashboardStats;
  return 'DashboardStats(totalDecks: ${_this.totalDecks}, totalFlashcards: ${_this.totalFlashcards}, dueCards: ${_this.dueCards}, studiedToday: ${_this.studiedToday}, recentDecks: ${_this.recentDecks})';
}


}

/// @nodoc
abstract mixin class $DashboardStatsCopyWith<$Res>  {
  factory $DashboardStatsCopyWith(DashboardStats value, $Res Function(DashboardStats) _then) = _$DashboardStatsCopyWithImpl;
@useResult
$Res call({
 int totalDecks, int totalFlashcards, int dueCards, int studiedToday, List<DeckSummary> recentDecks
});




}
/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._self, this._then);

  final DashboardStats _self;
  final $Res Function(DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDecks = null,Object? totalFlashcards = null,Object? dueCards = null,Object? studiedToday = null,Object? recentDecks = null,}) {
  return _then(DashboardStats(
totalDecks: null == totalDecks ? _self.totalDecks : totalDecks // ignore: cast_nullable_to_non_nullable
as int,totalFlashcards: null == totalFlashcards ? _self.totalFlashcards : totalFlashcards // ignore: cast_nullable_to_non_nullable
as int,dueCards: null == dueCards ? _self.dueCards : dueCards // ignore: cast_nullable_to_non_nullable
as int,studiedToday: null == studiedToday ? _self.studiedToday : studiedToday // ignore: cast_nullable_to_non_nullable
as int,recentDecks: null == recentDecks ? _self.recentDecks : recentDecks // ignore: cast_nullable_to_non_nullable
as List<DeckSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardStats].
extension DashboardStatsPatterns on DashboardStats {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardStats() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardStats value)  $default,){
final _that = this;
switch (_that) {
case _DashboardStats():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardStats value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardStats() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDecks,  int totalFlashcards,  int dueCards,  int studiedToday,  List<DeckSummary> recentDecks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardStats() when $default != null:
return $default(_that.totalDecks,_that.totalFlashcards,_that.dueCards,_that.studiedToday,_that.recentDecks);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDecks,  int totalFlashcards,  int dueCards,  int studiedToday,  List<DeckSummary> recentDecks)  $default,) {final _that = this;
switch (_that) {
case _DashboardStats():
return $default(_that.totalDecks,_that.totalFlashcards,_that.dueCards,_that.studiedToday,_that.recentDecks);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDecks,  int totalFlashcards,  int dueCards,  int studiedToday,  List<DeckSummary> recentDecks)?  $default,) {final _that = this;
switch (_that) {
case _DashboardStats() when $default != null:
return $default(_that.totalDecks,_that.totalFlashcards,_that.dueCards,_that.studiedToday,_that.recentDecks);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardStats implements DashboardStats {
  const _DashboardStats({required this.totalDecks, required this.totalFlashcards, required this.dueCards, required this.studiedToday,  List<DeckSummary> recentDecks = const <DeckSummary>[]}): _recentDecks = recentDecks;
  

@override final  int totalDecks;
@override final  int totalFlashcards;
@override final  int dueCards;
@override final  int studiedToday;
 final  List<DeckSummary> _recentDecks;
@override@JsonKey() List<DeckSummary> get recentDecks {
  if (_recentDecks is EqualUnmodifiableListView) return _recentDecks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentDecks);
}


/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsCopyWith<_DashboardStats> get copyWith => __$DashboardStatsCopyWithImpl<_DashboardStats>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStats&&(identical(other.totalDecks, totalDecks) || other.totalDecks == totalDecks)&&(identical(other.totalFlashcards, totalFlashcards) || other.totalFlashcards == totalFlashcards)&&(identical(other.dueCards, dueCards) || other.dueCards == dueCards)&&(identical(other.studiedToday, studiedToday) || other.studiedToday == studiedToday)&&const DeepCollectionEquality().equals(other.recentDecks, _recentDecks));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalDecks,totalFlashcards,dueCards,studiedToday,const DeepCollectionEquality().hash(_recentDecks));
}

@override
String toString() {
    return 'DashboardStats(totalDecks: $totalDecks, totalFlashcards: $totalFlashcards, dueCards: $dueCards, studiedToday: $studiedToday, recentDecks: $recentDecks)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsCopyWith<$Res> implements $DashboardStatsCopyWith<$Res> {
  factory _$DashboardStatsCopyWith(_DashboardStats value, $Res Function(_DashboardStats) _then) = __$DashboardStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalDecks, int totalFlashcards, int dueCards, int studiedToday, List<DeckSummary> recentDecks
});




}
/// @nodoc
class __$DashboardStatsCopyWithImpl<$Res>
    implements _$DashboardStatsCopyWith<$Res> {
  __$DashboardStatsCopyWithImpl(this._self, this._then);

  final _DashboardStats _self;
  final $Res Function(_DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDecks = null,Object? totalFlashcards = null,Object? dueCards = null,Object? studiedToday = null,Object? recentDecks = null,}) {
  return _then(_DashboardStats(
totalDecks: null == totalDecks ? _self.totalDecks : totalDecks // ignore: cast_nullable_to_non_nullable
as int,totalFlashcards: null == totalFlashcards ? _self.totalFlashcards : totalFlashcards // ignore: cast_nullable_to_non_nullable
as int,dueCards: null == dueCards ? _self.dueCards : dueCards // ignore: cast_nullable_to_non_nullable
as int,studiedToday: null == studiedToday ? _self.studiedToday : studiedToday // ignore: cast_nullable_to_non_nullable
as int,recentDecks: null == recentDecks ? _self._recentDecks : recentDecks // ignore: cast_nullable_to_non_nullable
as List<DeckSummary>,
  ));
}


}

// dart format on
