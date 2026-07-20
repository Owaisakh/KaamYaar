// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceModel {

 String get id; String get name; String get slug; String? get icon; String? get description; double get basePrice; bool get isActive; int get sortOrder;
/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceModelCopyWith<ServiceModel> get copyWith => _$ServiceModelCopyWithImpl<ServiceModel>(this as ServiceModel, _$identity);

  /// Serializes this ServiceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,description,basePrice,isActive,sortOrder);

@override
String toString() {
  return 'ServiceModel(id: $id, name: $name, slug: $slug, icon: $icon, description: $description, basePrice: $basePrice, isActive: $isActive, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ServiceModelCopyWith<$Res>  {
  factory $ServiceModelCopyWith(ServiceModel value, $Res Function(ServiceModel) _then) = _$ServiceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, String? icon, String? description, double basePrice, bool isActive, int sortOrder
});




}
/// @nodoc
class _$ServiceModelCopyWithImpl<$Res>
    implements $ServiceModelCopyWith<$Res> {
  _$ServiceModelCopyWithImpl(this._self, this._then);

  final ServiceModel _self;
  final $Res Function(ServiceModel) _then;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,Object? description = freezed,Object? basePrice = null,Object? isActive = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceModel].
extension ServiceModelPatterns on ServiceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String? icon,  String? description,  double basePrice,  bool isActive,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.description,_that.basePrice,_that.isActive,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String? icon,  String? description,  double basePrice,  bool isActive,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ServiceModel():
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.description,_that.basePrice,_that.isActive,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  String? icon,  String? description,  double basePrice,  bool isActive,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.description,_that.basePrice,_that.isActive,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceModel implements ServiceModel {
  const _ServiceModel({required this.id, required this.name, required this.slug, this.icon, this.description, required this.basePrice, this.isActive = true, this.sortOrder = 0});
  factory _ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override final  String? icon;
@override final  String? description;
@override final  double basePrice;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceModelCopyWith<_ServiceModel> get copyWith => __$ServiceModelCopyWithImpl<_ServiceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,description,basePrice,isActive,sortOrder);

@override
String toString() {
  return 'ServiceModel(id: $id, name: $name, slug: $slug, icon: $icon, description: $description, basePrice: $basePrice, isActive: $isActive, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ServiceModelCopyWith<$Res> implements $ServiceModelCopyWith<$Res> {
  factory _$ServiceModelCopyWith(_ServiceModel value, $Res Function(_ServiceModel) _then) = __$ServiceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, String? icon, String? description, double basePrice, bool isActive, int sortOrder
});




}
/// @nodoc
class __$ServiceModelCopyWithImpl<$Res>
    implements _$ServiceModelCopyWith<$Res> {
  __$ServiceModelCopyWithImpl(this._self, this._then);

  final _ServiceModel _self;
  final $Res Function(_ServiceModel) _then;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,Object? description = freezed,Object? basePrice = null,Object? isActive = null,Object? sortOrder = null,}) {
  return _then(_ServiceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
