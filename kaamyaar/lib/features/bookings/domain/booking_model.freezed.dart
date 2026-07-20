// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingModel {

 String get id;@JsonKey(name: 'customer_id') String get customerId;@JsonKey(name: 'worker_id') String? get workerId;@JsonKey(name: 'service_id') String get serviceId;@JsonKey(name: 'address_id') String get addressId;@JsonKey(name: 'problem_description') String get problemDescription;@JsonKey(name: 'scheduled_time') DateTime get scheduledTime;@JsonKey(name: 'estimated_price') double? get estimatedPrice;@JsonKey(name: 'final_price') double? get finalPrice; String get status;
/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingModelCopyWith<BookingModel> get copyWith => _$BookingModelCopyWithImpl<BookingModel>(this as BookingModel, _$identity);

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.problemDescription, problemDescription) || other.problemDescription == problemDescription)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,workerId,serviceId,addressId,problemDescription,scheduledTime,estimatedPrice,finalPrice,status);

@override
String toString() {
  return 'BookingModel(id: $id, customerId: $customerId, workerId: $workerId, serviceId: $serviceId, addressId: $addressId, problemDescription: $problemDescription, scheduledTime: $scheduledTime, estimatedPrice: $estimatedPrice, finalPrice: $finalPrice, status: $status)';
}


}

/// @nodoc
abstract mixin class $BookingModelCopyWith<$Res>  {
  factory $BookingModelCopyWith(BookingModel value, $Res Function(BookingModel) _then) = _$BookingModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'customer_id') String customerId,@JsonKey(name: 'worker_id') String? workerId,@JsonKey(name: 'service_id') String serviceId,@JsonKey(name: 'address_id') String addressId,@JsonKey(name: 'problem_description') String problemDescription,@JsonKey(name: 'scheduled_time') DateTime scheduledTime,@JsonKey(name: 'estimated_price') double? estimatedPrice,@JsonKey(name: 'final_price') double? finalPrice, String status
});




}
/// @nodoc
class _$BookingModelCopyWithImpl<$Res>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._self, this._then);

  final BookingModel _self;
  final $Res Function(BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? workerId = freezed,Object? serviceId = null,Object? addressId = null,Object? problemDescription = null,Object? scheduledTime = null,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,addressId: null == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String,problemDescription: null == problemDescription ? _self.problemDescription : problemDescription // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingModel].
extension BookingModelPatterns on BookingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'customer_id')  String customerId, @JsonKey(name: 'worker_id')  String? workerId, @JsonKey(name: 'service_id')  String serviceId, @JsonKey(name: 'address_id')  String addressId, @JsonKey(name: 'problem_description')  String problemDescription, @JsonKey(name: 'scheduled_time')  DateTime scheduledTime, @JsonKey(name: 'estimated_price')  double? estimatedPrice, @JsonKey(name: 'final_price')  double? finalPrice,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.customerId,_that.workerId,_that.serviceId,_that.addressId,_that.problemDescription,_that.scheduledTime,_that.estimatedPrice,_that.finalPrice,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'customer_id')  String customerId, @JsonKey(name: 'worker_id')  String? workerId, @JsonKey(name: 'service_id')  String serviceId, @JsonKey(name: 'address_id')  String addressId, @JsonKey(name: 'problem_description')  String problemDescription, @JsonKey(name: 'scheduled_time')  DateTime scheduledTime, @JsonKey(name: 'estimated_price')  double? estimatedPrice, @JsonKey(name: 'final_price')  double? finalPrice,  String status)  $default,) {final _that = this;
switch (_that) {
case _BookingModel():
return $default(_that.id,_that.customerId,_that.workerId,_that.serviceId,_that.addressId,_that.problemDescription,_that.scheduledTime,_that.estimatedPrice,_that.finalPrice,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'customer_id')  String customerId, @JsonKey(name: 'worker_id')  String? workerId, @JsonKey(name: 'service_id')  String serviceId, @JsonKey(name: 'address_id')  String addressId, @JsonKey(name: 'problem_description')  String problemDescription, @JsonKey(name: 'scheduled_time')  DateTime scheduledTime, @JsonKey(name: 'estimated_price')  double? estimatedPrice, @JsonKey(name: 'final_price')  double? finalPrice,  String status)?  $default,) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.customerId,_that.workerId,_that.serviceId,_that.addressId,_that.problemDescription,_that.scheduledTime,_that.estimatedPrice,_that.finalPrice,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingModel implements BookingModel {
  const _BookingModel({required this.id, @JsonKey(name: 'customer_id') required this.customerId, @JsonKey(name: 'worker_id') this.workerId, @JsonKey(name: 'service_id') required this.serviceId, @JsonKey(name: 'address_id') required this.addressId, @JsonKey(name: 'problem_description') required this.problemDescription, @JsonKey(name: 'scheduled_time') required this.scheduledTime, @JsonKey(name: 'estimated_price') this.estimatedPrice, @JsonKey(name: 'final_price') this.finalPrice, this.status = 'pending'});
  factory _BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'customer_id') final  String customerId;
@override@JsonKey(name: 'worker_id') final  String? workerId;
@override@JsonKey(name: 'service_id') final  String serviceId;
@override@JsonKey(name: 'address_id') final  String addressId;
@override@JsonKey(name: 'problem_description') final  String problemDescription;
@override@JsonKey(name: 'scheduled_time') final  DateTime scheduledTime;
@override@JsonKey(name: 'estimated_price') final  double? estimatedPrice;
@override@JsonKey(name: 'final_price') final  double? finalPrice;
@override@JsonKey() final  String status;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingModelCopyWith<_BookingModel> get copyWith => __$BookingModelCopyWithImpl<_BookingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.problemDescription, problemDescription) || other.problemDescription == problemDescription)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,workerId,serviceId,addressId,problemDescription,scheduledTime,estimatedPrice,finalPrice,status);

@override
String toString() {
  return 'BookingModel(id: $id, customerId: $customerId, workerId: $workerId, serviceId: $serviceId, addressId: $addressId, problemDescription: $problemDescription, scheduledTime: $scheduledTime, estimatedPrice: $estimatedPrice, finalPrice: $finalPrice, status: $status)';
}


}

/// @nodoc
abstract mixin class _$BookingModelCopyWith<$Res> implements $BookingModelCopyWith<$Res> {
  factory _$BookingModelCopyWith(_BookingModel value, $Res Function(_BookingModel) _then) = __$BookingModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'customer_id') String customerId,@JsonKey(name: 'worker_id') String? workerId,@JsonKey(name: 'service_id') String serviceId,@JsonKey(name: 'address_id') String addressId,@JsonKey(name: 'problem_description') String problemDescription,@JsonKey(name: 'scheduled_time') DateTime scheduledTime,@JsonKey(name: 'estimated_price') double? estimatedPrice,@JsonKey(name: 'final_price') double? finalPrice, String status
});




}
/// @nodoc
class __$BookingModelCopyWithImpl<$Res>
    implements _$BookingModelCopyWith<$Res> {
  __$BookingModelCopyWithImpl(this._self, this._then);

  final _BookingModel _self;
  final $Res Function(_BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? workerId = freezed,Object? serviceId = null,Object? addressId = null,Object? problemDescription = null,Object? scheduledTime = null,Object? estimatedPrice = freezed,Object? finalPrice = freezed,Object? status = null,}) {
  return _then(_BookingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,workerId: freezed == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,addressId: null == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String,problemDescription: null == problemDescription ? _self.problemDescription : problemDescription // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
