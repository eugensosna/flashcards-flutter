// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyCard {

 Flashcard get card; StudyProgress? get progress;
/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyCardCopyWith<StudyCard> get copyWith => _$StudyCardCopyWithImpl<StudyCard>(this as StudyCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyCard&&(identical(other.card, _this.card) || other.card == _this.card)&&(identical(other.progress, _this.progress) || other.progress == _this.progress));
}


@override
int get hashCode {
  final _this = this as StudyCard;
  return Object.hash(runtimeType,_this.card,_this.progress);
}

@override
String toString() {
  final _this = this as StudyCard;
  return 'StudyCard(card: ${_this.card}, progress: ${_this.progress})';
}


}

/// @nodoc
abstract mixin class $StudyCardCopyWith<$Res>  {
  factory $StudyCardCopyWith(StudyCard value, $Res Function(StudyCard) _then) = _$StudyCardCopyWithImpl;
@useResult
$Res call({
 Flashcard card, StudyProgress? progress
});


$FlashcardCopyWith<$Res> get card;$StudyProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class _$StudyCardCopyWithImpl<$Res>
    implements $StudyCardCopyWith<$Res> {
  _$StudyCardCopyWithImpl(this._self, this._then);

  final StudyCard _self;
  final $Res Function(StudyCard) _then;

/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? progress = freezed,}) {
  return _then(StudyCard(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as Flashcard,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgress?,
  ));
}
/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashcardCopyWith<$Res> get card {
  
  return $FlashcardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $StudyProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyCard].
extension StudyCardPatterns on StudyCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyCard value)  $default,){
final _that = this;
switch (_that) {
case _StudyCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyCard value)?  $default,){
final _that = this;
switch (_that) {
case _StudyCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Flashcard card,  StudyProgress? progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyCard() when $default != null:
return $default(_that.card,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Flashcard card,  StudyProgress? progress)  $default,) {final _that = this;
switch (_that) {
case _StudyCard():
return $default(_that.card,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Flashcard card,  StudyProgress? progress)?  $default,) {final _that = this;
switch (_that) {
case _StudyCard() when $default != null:
return $default(_that.card,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _StudyCard extends StudyCard {
  const _StudyCard({required this.card, this.progress}): super._();
  

@override final  Flashcard card;
@override final  StudyProgress? progress;

/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyCardCopyWith<_StudyCard> get copyWith => __$StudyCardCopyWithImpl<_StudyCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyCard&&(identical(other.card, card) || other.card == card)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,card,progress);
}

@override
String toString() {
    return 'StudyCard(card: $card, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$StudyCardCopyWith<$Res> implements $StudyCardCopyWith<$Res> {
  factory _$StudyCardCopyWith(_StudyCard value, $Res Function(_StudyCard) _then) = __$StudyCardCopyWithImpl;
@override @useResult
$Res call({
 Flashcard card, StudyProgress? progress
});


@override $FlashcardCopyWith<$Res> get card;@override $StudyProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class __$StudyCardCopyWithImpl<$Res>
    implements _$StudyCardCopyWith<$Res> {
  __$StudyCardCopyWithImpl(this._self, this._then);

  final _StudyCard _self;
  final $Res Function(_StudyCard) _then;

/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? progress = freezed,}) {
  return _then(_StudyCard(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as Flashcard,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgress?,
  ));
}

/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashcardCopyWith<$Res> get card {
  
  return $FlashcardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StudyCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $StudyProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
