// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyProgress {

 int get id; int get flashcardId; int get repetitions; int get interval; double get easeFactor; DateTime get dueDate; DateTime? get lastReviewedAt; int get reviewCount;
/// Create a copy of StudyProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyProgressCopyWith<StudyProgress> get copyWith => _$StudyProgressCopyWithImpl<StudyProgress>(this as StudyProgress, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyProgress&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.flashcardId, _this.flashcardId) || other.flashcardId == _this.flashcardId)&&(identical(other.repetitions, _this.repetitions) || other.repetitions == _this.repetitions)&&(identical(other.interval, _this.interval) || other.interval == _this.interval)&&(identical(other.easeFactor, _this.easeFactor) || other.easeFactor == _this.easeFactor)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.lastReviewedAt, _this.lastReviewedAt) || other.lastReviewedAt == _this.lastReviewedAt)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount));
}


@override
int get hashCode {
  final _this = this as StudyProgress;
  return Object.hash(runtimeType,_this.id,_this.flashcardId,_this.repetitions,_this.interval,_this.easeFactor,_this.dueDate,_this.lastReviewedAt,_this.reviewCount);
}

@override
String toString() {
  final _this = this as StudyProgress;
  return 'StudyProgress(id: ${_this.id}, flashcardId: ${_this.flashcardId}, repetitions: ${_this.repetitions}, interval: ${_this.interval}, easeFactor: ${_this.easeFactor}, dueDate: ${_this.dueDate}, lastReviewedAt: ${_this.lastReviewedAt}, reviewCount: ${_this.reviewCount})';
}


}

/// @nodoc
abstract mixin class $StudyProgressCopyWith<$Res>  {
  factory $StudyProgressCopyWith(StudyProgress value, $Res Function(StudyProgress) _then) = _$StudyProgressCopyWithImpl;
@useResult
$Res call({
 int id, int flashcardId, int repetitions, int interval, double easeFactor, DateTime dueDate, DateTime? lastReviewedAt, int reviewCount
});




}
/// @nodoc
class _$StudyProgressCopyWithImpl<$Res>
    implements $StudyProgressCopyWith<$Res> {
  _$StudyProgressCopyWithImpl(this._self, this._then);

  final StudyProgress _self;
  final $Res Function(StudyProgress) _then;

/// Create a copy of StudyProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? flashcardId = null,Object? repetitions = null,Object? interval = null,Object? easeFactor = null,Object? dueDate = null,Object? lastReviewedAt = freezed,Object? reviewCount = null,}) {
  return _then(StudyProgress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,flashcardId: null == flashcardId ? _self.flashcardId : flashcardId // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastReviewedAt: freezed == lastReviewedAt ? _self.lastReviewedAt : lastReviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyProgress].
extension StudyProgressPatterns on StudyProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyProgress value)  $default,){
final _that = this;
switch (_that) {
case _StudyProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyProgress value)?  $default,){
final _that = this;
switch (_that) {
case _StudyProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int flashcardId,  int repetitions,  int interval,  double easeFactor,  DateTime dueDate,  DateTime? lastReviewedAt,  int reviewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyProgress() when $default != null:
return $default(_that.id,_that.flashcardId,_that.repetitions,_that.interval,_that.easeFactor,_that.dueDate,_that.lastReviewedAt,_that.reviewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int flashcardId,  int repetitions,  int interval,  double easeFactor,  DateTime dueDate,  DateTime? lastReviewedAt,  int reviewCount)  $default,) {final _that = this;
switch (_that) {
case _StudyProgress():
return $default(_that.id,_that.flashcardId,_that.repetitions,_that.interval,_that.easeFactor,_that.dueDate,_that.lastReviewedAt,_that.reviewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int flashcardId,  int repetitions,  int interval,  double easeFactor,  DateTime dueDate,  DateTime? lastReviewedAt,  int reviewCount)?  $default,) {final _that = this;
switch (_that) {
case _StudyProgress() when $default != null:
return $default(_that.id,_that.flashcardId,_that.repetitions,_that.interval,_that.easeFactor,_that.dueDate,_that.lastReviewedAt,_that.reviewCount);case _:
  return null;

}
}

}

/// @nodoc


class _StudyProgress extends StudyProgress {
  const _StudyProgress({required this.id, required this.flashcardId, this.repetitions = 0, this.interval = 0, this.easeFactor = 2.5, required this.dueDate, this.lastReviewedAt, this.reviewCount = 0}): super._();
  

@override final  int id;
@override final  int flashcardId;
@override@JsonKey() final  int repetitions;
@override@JsonKey() final  int interval;
@override@JsonKey() final  double easeFactor;
@override final  DateTime dueDate;
@override final  DateTime? lastReviewedAt;
@override@JsonKey() final  int reviewCount;

/// Create a copy of StudyProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyProgressCopyWith<_StudyProgress> get copyWith => __$StudyProgressCopyWithImpl<_StudyProgress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.flashcardId, flashcardId) || other.flashcardId == flashcardId)&&(identical(other.repetitions, repetitions) || other.repetitions == repetitions)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.lastReviewedAt, lastReviewedAt) || other.lastReviewedAt == lastReviewedAt)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,flashcardId,repetitions,interval,easeFactor,dueDate,lastReviewedAt,reviewCount);
}

@override
String toString() {
    return 'StudyProgress(id: $id, flashcardId: $flashcardId, repetitions: $repetitions, interval: $interval, easeFactor: $easeFactor, dueDate: $dueDate, lastReviewedAt: $lastReviewedAt, reviewCount: $reviewCount)';
}


}

/// @nodoc
abstract mixin class _$StudyProgressCopyWith<$Res> implements $StudyProgressCopyWith<$Res> {
  factory _$StudyProgressCopyWith(_StudyProgress value, $Res Function(_StudyProgress) _then) = __$StudyProgressCopyWithImpl;
@override @useResult
$Res call({
 int id, int flashcardId, int repetitions, int interval, double easeFactor, DateTime dueDate, DateTime? lastReviewedAt, int reviewCount
});




}
/// @nodoc
class __$StudyProgressCopyWithImpl<$Res>
    implements _$StudyProgressCopyWith<$Res> {
  __$StudyProgressCopyWithImpl(this._self, this._then);

  final _StudyProgress _self;
  final $Res Function(_StudyProgress) _then;

/// Create a copy of StudyProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? flashcardId = null,Object? repetitions = null,Object? interval = null,Object? easeFactor = null,Object? dueDate = null,Object? lastReviewedAt = freezed,Object? reviewCount = null,}) {
  return _then(_StudyProgress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,flashcardId: null == flashcardId ? _self.flashcardId : flashcardId // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastReviewedAt: freezed == lastReviewedAt ? _self.lastReviewedAt : lastReviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
