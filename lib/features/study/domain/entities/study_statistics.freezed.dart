// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyReviewCount {

 DateTime get day; int get count;
/// Create a copy of DailyReviewCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReviewCountCopyWith<DailyReviewCount> get copyWith => _$DailyReviewCountCopyWithImpl<DailyReviewCount>(this as DailyReviewCount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyReviewCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReviewCount&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as DailyReviewCount;
  return Object.hash(runtimeType,_this.day,_this.count);
}

@override
String toString() {
  final _this = this as DailyReviewCount;
  return 'DailyReviewCount(day: ${_this.day}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $DailyReviewCountCopyWith<$Res>  {
  factory $DailyReviewCountCopyWith(DailyReviewCount value, $Res Function(DailyReviewCount) _then) = _$DailyReviewCountCopyWithImpl;
@useResult
$Res call({
 DateTime day, int count
});




}
/// @nodoc
class _$DailyReviewCountCopyWithImpl<$Res>
    implements $DailyReviewCountCopyWith<$Res> {
  _$DailyReviewCountCopyWithImpl(this._self, this._then);

  final DailyReviewCount _self;
  final $Res Function(DailyReviewCount) _then;

/// Create a copy of DailyReviewCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? count = null,}) {
  return _then(DailyReviewCount(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReviewCount].
extension DailyReviewCountPatterns on DailyReviewCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReviewCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReviewCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReviewCount value)  $default,){
final _that = this;
switch (_that) {
case _DailyReviewCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReviewCount value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReviewCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReviewCount() when $default != null:
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  int count)  $default,) {final _that = this;
switch (_that) {
case _DailyReviewCount():
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  int count)?  $default,) {final _that = this;
switch (_that) {
case _DailyReviewCount() when $default != null:
return $default(_that.day,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _DailyReviewCount implements DailyReviewCount {
  const _DailyReviewCount({required this.day, required this.count});
  

@override final  DateTime day;
@override final  int count;

/// Create a copy of DailyReviewCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReviewCountCopyWith<_DailyReviewCount> get copyWith => __$DailyReviewCountCopyWithImpl<_DailyReviewCount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReviewCount&&(identical(other.day, day) || other.day == day)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day,count);
}

@override
String toString() {
    return 'DailyReviewCount(day: $day, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DailyReviewCountCopyWith<$Res> implements $DailyReviewCountCopyWith<$Res> {
  factory _$DailyReviewCountCopyWith(_DailyReviewCount value, $Res Function(_DailyReviewCount) _then) = __$DailyReviewCountCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, int count
});




}
/// @nodoc
class __$DailyReviewCountCopyWithImpl<$Res>
    implements _$DailyReviewCountCopyWith<$Res> {
  __$DailyReviewCountCopyWithImpl(this._self, this._then);

  final _DailyReviewCount _self;
  final $Res Function(_DailyReviewCount) _then;

/// Create a copy of DailyReviewCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? count = null,}) {
  return _then(_DailyReviewCount(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StudyStatistics {

 int get totalCards; int get dueCards; int get newCards; int get matureCards; int get reviewsToday; int get studiedToday; int get totalReviews; double get averageEaseFactor; List<DailyReviewCount> get history;
/// Create a copy of StudyStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyStatisticsCopyWith<StudyStatistics> get copyWith => _$StudyStatisticsCopyWithImpl<StudyStatistics>(this as StudyStatistics, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyStatistics;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyStatistics&&(identical(other.totalCards, _this.totalCards) || other.totalCards == _this.totalCards)&&(identical(other.dueCards, _this.dueCards) || other.dueCards == _this.dueCards)&&(identical(other.newCards, _this.newCards) || other.newCards == _this.newCards)&&(identical(other.matureCards, _this.matureCards) || other.matureCards == _this.matureCards)&&(identical(other.reviewsToday, _this.reviewsToday) || other.reviewsToday == _this.reviewsToday)&&(identical(other.studiedToday, _this.studiedToday) || other.studiedToday == _this.studiedToday)&&(identical(other.totalReviews, _this.totalReviews) || other.totalReviews == _this.totalReviews)&&(identical(other.averageEaseFactor, _this.averageEaseFactor) || other.averageEaseFactor == _this.averageEaseFactor)&&const DeepCollectionEquality().equals(other.history, _this.history));
}


@override
int get hashCode {
  final _this = this as StudyStatistics;
  return Object.hash(runtimeType,_this.totalCards,_this.dueCards,_this.newCards,_this.matureCards,_this.reviewsToday,_this.studiedToday,_this.totalReviews,_this.averageEaseFactor,const DeepCollectionEquality().hash(_this.history));
}

@override
String toString() {
  final _this = this as StudyStatistics;
  return 'StudyStatistics(totalCards: ${_this.totalCards}, dueCards: ${_this.dueCards}, newCards: ${_this.newCards}, matureCards: ${_this.matureCards}, reviewsToday: ${_this.reviewsToday}, studiedToday: ${_this.studiedToday}, totalReviews: ${_this.totalReviews}, averageEaseFactor: ${_this.averageEaseFactor}, history: ${_this.history})';
}


}

/// @nodoc
abstract mixin class $StudyStatisticsCopyWith<$Res>  {
  factory $StudyStatisticsCopyWith(StudyStatistics value, $Res Function(StudyStatistics) _then) = _$StudyStatisticsCopyWithImpl;
@useResult
$Res call({
 int totalCards, int dueCards, int newCards, int matureCards, int reviewsToday, int studiedToday, int totalReviews, double averageEaseFactor, List<DailyReviewCount> history
});




}
/// @nodoc
class _$StudyStatisticsCopyWithImpl<$Res>
    implements $StudyStatisticsCopyWith<$Res> {
  _$StudyStatisticsCopyWithImpl(this._self, this._then);

  final StudyStatistics _self;
  final $Res Function(StudyStatistics) _then;

/// Create a copy of StudyStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCards = null,Object? dueCards = null,Object? newCards = null,Object? matureCards = null,Object? reviewsToday = null,Object? studiedToday = null,Object? totalReviews = null,Object? averageEaseFactor = null,Object? history = null,}) {
  return _then(StudyStatistics(
totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,dueCards: null == dueCards ? _self.dueCards : dueCards // ignore: cast_nullable_to_non_nullable
as int,newCards: null == newCards ? _self.newCards : newCards // ignore: cast_nullable_to_non_nullable
as int,matureCards: null == matureCards ? _self.matureCards : matureCards // ignore: cast_nullable_to_non_nullable
as int,reviewsToday: null == reviewsToday ? _self.reviewsToday : reviewsToday // ignore: cast_nullable_to_non_nullable
as int,studiedToday: null == studiedToday ? _self.studiedToday : studiedToday // ignore: cast_nullable_to_non_nullable
as int,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageEaseFactor: null == averageEaseFactor ? _self.averageEaseFactor : averageEaseFactor // ignore: cast_nullable_to_non_nullable
as double,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<DailyReviewCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyStatistics].
extension StudyStatisticsPatterns on StudyStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyStatistics value)  $default,){
final _that = this;
switch (_that) {
case _StudyStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _StudyStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCards,  int dueCards,  int newCards,  int matureCards,  int reviewsToday,  int studiedToday,  int totalReviews,  double averageEaseFactor,  List<DailyReviewCount> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyStatistics() when $default != null:
return $default(_that.totalCards,_that.dueCards,_that.newCards,_that.matureCards,_that.reviewsToday,_that.studiedToday,_that.totalReviews,_that.averageEaseFactor,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCards,  int dueCards,  int newCards,  int matureCards,  int reviewsToday,  int studiedToday,  int totalReviews,  double averageEaseFactor,  List<DailyReviewCount> history)  $default,) {final _that = this;
switch (_that) {
case _StudyStatistics():
return $default(_that.totalCards,_that.dueCards,_that.newCards,_that.matureCards,_that.reviewsToday,_that.studiedToday,_that.totalReviews,_that.averageEaseFactor,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCards,  int dueCards,  int newCards,  int matureCards,  int reviewsToday,  int studiedToday,  int totalReviews,  double averageEaseFactor,  List<DailyReviewCount> history)?  $default,) {final _that = this;
switch (_that) {
case _StudyStatistics() when $default != null:
return $default(_that.totalCards,_that.dueCards,_that.newCards,_that.matureCards,_that.reviewsToday,_that.studiedToday,_that.totalReviews,_that.averageEaseFactor,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _StudyStatistics extends StudyStatistics {
  const _StudyStatistics({required this.totalCards, required this.dueCards, required this.newCards, required this.matureCards, required this.reviewsToday, required this.studiedToday, required this.totalReviews, required this.averageEaseFactor,  List<DailyReviewCount> history = const <DailyReviewCount>[]}): _history = history,super._();
  

@override final  int totalCards;
@override final  int dueCards;
@override final  int newCards;
@override final  int matureCards;
@override final  int reviewsToday;
@override final  int studiedToday;
@override final  int totalReviews;
@override final  double averageEaseFactor;
 final  List<DailyReviewCount> _history;
@override@JsonKey() List<DailyReviewCount> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of StudyStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyStatisticsCopyWith<_StudyStatistics> get copyWith => __$StudyStatisticsCopyWithImpl<_StudyStatistics>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyStatistics&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.dueCards, dueCards) || other.dueCards == dueCards)&&(identical(other.newCards, newCards) || other.newCards == newCards)&&(identical(other.matureCards, matureCards) || other.matureCards == matureCards)&&(identical(other.reviewsToday, reviewsToday) || other.reviewsToday == reviewsToday)&&(identical(other.studiedToday, studiedToday) || other.studiedToday == studiedToday)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.averageEaseFactor, averageEaseFactor) || other.averageEaseFactor == averageEaseFactor)&&const DeepCollectionEquality().equals(other.history, _history));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalCards,dueCards,newCards,matureCards,reviewsToday,studiedToday,totalReviews,averageEaseFactor,const DeepCollectionEquality().hash(_history));
}

@override
String toString() {
    return 'StudyStatistics(totalCards: $totalCards, dueCards: $dueCards, newCards: $newCards, matureCards: $matureCards, reviewsToday: $reviewsToday, studiedToday: $studiedToday, totalReviews: $totalReviews, averageEaseFactor: $averageEaseFactor, history: $history)';
}


}

/// @nodoc
abstract mixin class _$StudyStatisticsCopyWith<$Res> implements $StudyStatisticsCopyWith<$Res> {
  factory _$StudyStatisticsCopyWith(_StudyStatistics value, $Res Function(_StudyStatistics) _then) = __$StudyStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int totalCards, int dueCards, int newCards, int matureCards, int reviewsToday, int studiedToday, int totalReviews, double averageEaseFactor, List<DailyReviewCount> history
});




}
/// @nodoc
class __$StudyStatisticsCopyWithImpl<$Res>
    implements _$StudyStatisticsCopyWith<$Res> {
  __$StudyStatisticsCopyWithImpl(this._self, this._then);

  final _StudyStatistics _self;
  final $Res Function(_StudyStatistics) _then;

/// Create a copy of StudyStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCards = null,Object? dueCards = null,Object? newCards = null,Object? matureCards = null,Object? reviewsToday = null,Object? studiedToday = null,Object? totalReviews = null,Object? averageEaseFactor = null,Object? history = null,}) {
  return _then(_StudyStatistics(
totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,dueCards: null == dueCards ? _self.dueCards : dueCards // ignore: cast_nullable_to_non_nullable
as int,newCards: null == newCards ? _self.newCards : newCards // ignore: cast_nullable_to_non_nullable
as int,matureCards: null == matureCards ? _self.matureCards : matureCards // ignore: cast_nullable_to_non_nullable
as int,reviewsToday: null == reviewsToday ? _self.reviewsToday : reviewsToday // ignore: cast_nullable_to_non_nullable
as int,studiedToday: null == studiedToday ? _self.studiedToday : studiedToday // ignore: cast_nullable_to_non_nullable
as int,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageEaseFactor: null == averageEaseFactor ? _self.averageEaseFactor : averageEaseFactor // ignore: cast_nullable_to_non_nullable
as double,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<DailyReviewCount>,
  ));
}


}

// dart format on
