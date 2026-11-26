// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudySession {

 int get deckId; List<StudyCard> get cards; int get currentIndex; bool get isFlipped; int get reviewedCount;
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySessionCopyWith<StudySession> get copyWith => _$StudySessionCopyWithImpl<StudySession>(this as StudySession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudySession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySession&&(identical(other.deckId, _this.deckId) || other.deckId == _this.deckId)&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.currentIndex, _this.currentIndex) || other.currentIndex == _this.currentIndex)&&(identical(other.isFlipped, _this.isFlipped) || other.isFlipped == _this.isFlipped)&&(identical(other.reviewedCount, _this.reviewedCount) || other.reviewedCount == _this.reviewedCount));
}


@override
int get hashCode {
  final _this = this as StudySession;
  return Object.hash(runtimeType,_this.deckId,const DeepCollectionEquality().hash(_this.cards),_this.currentIndex,_this.isFlipped,_this.reviewedCount);
}

@override
String toString() {
  final _this = this as StudySession;
  return 'StudySession(deckId: ${_this.deckId}, cards: ${_this.cards}, currentIndex: ${_this.currentIndex}, isFlipped: ${_this.isFlipped}, reviewedCount: ${_this.reviewedCount})';
}


}

/// @nodoc
abstract mixin class $StudySessionCopyWith<$Res>  {
  factory $StudySessionCopyWith(StudySession value, $Res Function(StudySession) _then) = _$StudySessionCopyWithImpl;
@useResult
$Res call({
 int deckId, List<StudyCard> cards, int currentIndex, bool isFlipped, int reviewedCount
});




}
/// @nodoc
class _$StudySessionCopyWithImpl<$Res>
    implements $StudySessionCopyWith<$Res> {
  _$StudySessionCopyWithImpl(this._self, this._then);

  final StudySession _self;
  final $Res Function(StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deckId = null,Object? cards = null,Object? currentIndex = null,Object? isFlipped = null,Object? reviewedCount = null,}) {
  return _then(StudySession(
deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<StudyCard>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isFlipped: null == isFlipped ? _self.isFlipped : isFlipped // ignore: cast_nullable_to_non_nullable
as bool,reviewedCount: null == reviewedCount ? _self.reviewedCount : reviewedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudySession].
extension StudySessionPatterns on StudySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySession value)  $default,){
final _that = this;
switch (_that) {
case _StudySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySession value)?  $default,){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int deckId,  List<StudyCard> cards,  int currentIndex,  bool isFlipped,  int reviewedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.deckId,_that.cards,_that.currentIndex,_that.isFlipped,_that.reviewedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int deckId,  List<StudyCard> cards,  int currentIndex,  bool isFlipped,  int reviewedCount)  $default,) {final _that = this;
switch (_that) {
case _StudySession():
return $default(_that.deckId,_that.cards,_that.currentIndex,_that.isFlipped,_that.reviewedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int deckId,  List<StudyCard> cards,  int currentIndex,  bool isFlipped,  int reviewedCount)?  $default,) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.deckId,_that.cards,_that.currentIndex,_that.isFlipped,_that.reviewedCount);case _:
  return null;

}
}

}

/// @nodoc


class _StudySession extends StudySession {
  const _StudySession({required this.deckId, required  List<StudyCard> cards, this.currentIndex = 0, this.isFlipped = false, this.reviewedCount = 0}): _cards = cards,super._();
  

@override final  int deckId;
 final  List<StudyCard> _cards;
@override List<StudyCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  bool isFlipped;
@override@JsonKey() final  int reviewedCount;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySessionCopyWith<_StudySession> get copyWith => __$StudySessionCopyWithImpl<_StudySession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySession&&(identical(other.deckId, deckId) || other.deckId == deckId)&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isFlipped, isFlipped) || other.isFlipped == isFlipped)&&(identical(other.reviewedCount, reviewedCount) || other.reviewedCount == reviewedCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,deckId,const DeepCollectionEquality().hash(_cards),currentIndex,isFlipped,reviewedCount);
}

@override
String toString() {
    return 'StudySession(deckId: $deckId, cards: $cards, currentIndex: $currentIndex, isFlipped: $isFlipped, reviewedCount: $reviewedCount)';
}


}

/// @nodoc
abstract mixin class _$StudySessionCopyWith<$Res> implements $StudySessionCopyWith<$Res> {
  factory _$StudySessionCopyWith(_StudySession value, $Res Function(_StudySession) _then) = __$StudySessionCopyWithImpl;
@override @useResult
$Res call({
 int deckId, List<StudyCard> cards, int currentIndex, bool isFlipped, int reviewedCount
});




}
/// @nodoc
class __$StudySessionCopyWithImpl<$Res>
    implements _$StudySessionCopyWith<$Res> {
  __$StudySessionCopyWithImpl(this._self, this._then);

  final _StudySession _self;
  final $Res Function(_StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deckId = null,Object? cards = null,Object? currentIndex = null,Object? isFlipped = null,Object? reviewedCount = null,}) {
  return _then(_StudySession(
deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<StudyCard>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isFlipped: null == isFlipped ? _self.isFlipped : isFlipped // ignore: cast_nullable_to_non_nullable
as bool,reviewedCount: null == reviewedCount ? _self.reviewedCount : reviewedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
