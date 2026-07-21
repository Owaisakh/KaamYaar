// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_analytics_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminAnalyticsState {

 int get activeBookings; double get totalRevenue;
/// Create a copy of AdminAnalyticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAnalyticsStateCopyWith<AdminAnalyticsState> get copyWith => _$AdminAnalyticsStateCopyWithImpl<AdminAnalyticsState>(this as AdminAnalyticsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAnalyticsState&&(identical(other.activeBookings, activeBookings) || other.activeBookings == activeBookings)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue));
}


@override
int get hashCode => Object.hash(runtimeType,activeBookings,totalRevenue);

@override
String toString() {
  return 'AdminAnalyticsState(activeBookings: $activeBookings, totalRevenue: $totalRevenue)';
}


}

/// @nodoc
abstract mixin class $AdminAnalyticsStateCopyWith<$Res>  {
  factory $AdminAnalyticsStateCopyWith(AdminAnalyticsState value, $Res Function(AdminAnalyticsState) _then) = _$AdminAnalyticsStateCopyWithImpl;
@useResult
$Res call({
 int activeBookings, double totalRevenue
});




}
/// @nodoc
class _$AdminAnalyticsStateCopyWithImpl<$Res>
    implements $AdminAnalyticsStateCopyWith<$Res> {
  _$AdminAnalyticsStateCopyWithImpl(this._self, this._then);

  final AdminAnalyticsState _self;
  final $Res Function(AdminAnalyticsState) _then;

/// Create a copy of AdminAnalyticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeBookings = null,Object? totalRevenue = null,}) {
  return _then(_self.copyWith(
activeBookings: null == activeBookings ? _self.activeBookings : activeBookings // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminAnalyticsState].
extension AdminAnalyticsStatePatterns on AdminAnalyticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAnalyticsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAnalyticsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAnalyticsState value)  $default,){
final _that = this;
switch (_that) {
case _AdminAnalyticsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAnalyticsState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAnalyticsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeBookings,  double totalRevenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAnalyticsState() when $default != null:
return $default(_that.activeBookings,_that.totalRevenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeBookings,  double totalRevenue)  $default,) {final _that = this;
switch (_that) {
case _AdminAnalyticsState():
return $default(_that.activeBookings,_that.totalRevenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeBookings,  double totalRevenue)?  $default,) {final _that = this;
switch (_that) {
case _AdminAnalyticsState() when $default != null:
return $default(_that.activeBookings,_that.totalRevenue);case _:
  return null;

}
}

}

/// @nodoc


class _AdminAnalyticsState implements AdminAnalyticsState {
  const _AdminAnalyticsState({this.activeBookings = 0, this.totalRevenue = 0.0});
  

@override@JsonKey() final  int activeBookings;
@override@JsonKey() final  double totalRevenue;

/// Create a copy of AdminAnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAnalyticsStateCopyWith<_AdminAnalyticsState> get copyWith => __$AdminAnalyticsStateCopyWithImpl<_AdminAnalyticsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAnalyticsState&&(identical(other.activeBookings, activeBookings) || other.activeBookings == activeBookings)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue));
}


@override
int get hashCode => Object.hash(runtimeType,activeBookings,totalRevenue);

@override
String toString() {
  return 'AdminAnalyticsState(activeBookings: $activeBookings, totalRevenue: $totalRevenue)';
}


}

/// @nodoc
abstract mixin class _$AdminAnalyticsStateCopyWith<$Res> implements $AdminAnalyticsStateCopyWith<$Res> {
  factory _$AdminAnalyticsStateCopyWith(_AdminAnalyticsState value, $Res Function(_AdminAnalyticsState) _then) = __$AdminAnalyticsStateCopyWithImpl;
@override @useResult
$Res call({
 int activeBookings, double totalRevenue
});




}
/// @nodoc
class __$AdminAnalyticsStateCopyWithImpl<$Res>
    implements _$AdminAnalyticsStateCopyWith<$Res> {
  __$AdminAnalyticsStateCopyWithImpl(this._self, this._then);

  final _AdminAnalyticsState _self;
  final $Res Function(_AdminAnalyticsState) _then;

/// Create a copy of AdminAnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeBookings = null,Object? totalRevenue = null,}) {
  return _then(_AdminAnalyticsState(
activeBookings: null == activeBookings ? _self.activeBookings : activeBookings // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
