// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeckSummary {

 Deck get deck; int get cardCount; int get dueCount;
/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeckSummaryCopyWith<DeckSummary> get copyWith => _$DeckSummaryCopyWithImpl<DeckSummary>(this as DeckSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeckSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeckSummary&&(identical(other.deck, _this.deck) || other.deck == _this.deck)&&(identical(other.cardCount, _this.cardCount) || other.cardCount == _this.cardCount)&&(identical(other.dueCount, _this.dueCount) || other.dueCount == _this.dueCount));
}


@override
int get hashCode {
  final _this = this as DeckSummary;
  return Object.hash(runtimeType,_this.deck,_this.cardCount,_this.dueCount);
}

@override
String toString() {
  final _this = this as DeckSummary;
  return 'DeckSummary(deck: ${_this.deck}, cardCount: ${_this.cardCount}, dueCount: ${_this.dueCount})';
}


}

/// @nodoc
abstract mixin class $DeckSummaryCopyWith<$Res>  {
  factory $DeckSummaryCopyWith(DeckSummary value, $Res Function(DeckSummary) _then) = _$DeckSummaryCopyWithImpl;
@useResult
$Res call({
 Deck deck, int cardCount, int dueCount
});


$DeckCopyWith<$Res> get deck;

}
/// @nodoc
class _$DeckSummaryCopyWithImpl<$Res>
    implements $DeckSummaryCopyWith<$Res> {
  _$DeckSummaryCopyWithImpl(this._self, this._then);

  final DeckSummary _self;
  final $Res Function(DeckSummary) _then;

/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deck = null,Object? cardCount = null,Object? dueCount = null,}) {
  return _then(DeckSummary(
deck: null == deck ? _self.deck : deck // ignore: cast_nullable_to_non_nullable
as Deck,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,dueCount: null == dueCount ? _self.dueCount : dueCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeckCopyWith<$Res> get deck {
  
  return $DeckCopyWith<$Res>(_self.deck, (value) {
    return _then(_self.copyWith(deck: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeckSummary].
extension DeckSummaryPatterns on DeckSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeckSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeckSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeckSummary value)  $default,){
final _that = this;
switch (_that) {
case _DeckSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeckSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DeckSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Deck deck,  int cardCount,  int dueCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeckSummary() when $default != null:
return $default(_that.deck,_that.cardCount,_that.dueCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Deck deck,  int cardCount,  int dueCount)  $default,) {final _that = this;
switch (_that) {
case _DeckSummary():
return $default(_that.deck,_that.cardCount,_that.dueCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Deck deck,  int cardCount,  int dueCount)?  $default,) {final _that = this;
switch (_that) {
case _DeckSummary() when $default != null:
return $default(_that.deck,_that.cardCount,_that.dueCount);case _:
  return null;

}
}

}

/// @nodoc


class _DeckSummary extends DeckSummary {
  const _DeckSummary({required this.deck, required this.cardCount, required this.dueCount}): super._();
  

@override final  Deck deck;
@override final  int cardCount;
@override final  int dueCount;

/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeckSummaryCopyWith<_DeckSummary> get copyWith => __$DeckSummaryCopyWithImpl<_DeckSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeckSummary&&(identical(other.deck, deck) || other.deck == deck)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.dueCount, dueCount) || other.dueCount == dueCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,deck,cardCount,dueCount);
}

@override
String toString() {
    return 'DeckSummary(deck: $deck, cardCount: $cardCount, dueCount: $dueCount)';
}


}

/// @nodoc
abstract mixin class _$DeckSummaryCopyWith<$Res> implements $DeckSummaryCopyWith<$Res> {
  factory _$DeckSummaryCopyWith(_DeckSummary value, $Res Function(_DeckSummary) _then) = __$DeckSummaryCopyWithImpl;
@override @useResult
$Res call({
 Deck deck, int cardCount, int dueCount
});


@override $DeckCopyWith<$Res> get deck;

}
/// @nodoc
class __$DeckSummaryCopyWithImpl<$Res>
    implements _$DeckSummaryCopyWith<$Res> {
  __$DeckSummaryCopyWithImpl(this._self, this._then);

  final _DeckSummary _self;
  final $Res Function(_DeckSummary) _then;

/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deck = null,Object? cardCount = null,Object? dueCount = null,}) {
  return _then(_DeckSummary(
deck: null == deck ? _self.deck : deck // ignore: cast_nullable_to_non_nullable
as Deck,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,dueCount: null == dueCount ? _self.dueCount : dueCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DeckSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeckCopyWith<$Res> get deck {
  
  return $DeckCopyWith<$Res>(_self.deck, (value) {
    return _then(_self.copyWith(deck: value));
  });
}
}

// dart format on
