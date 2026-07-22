// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_document_admin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerDocumentAdminModel {

 String get id;@JsonKey(name: 'worker_id') String get workerId;@JsonKey(name: 'document_type') String get documentType;@JsonKey(name: 'file_url') String get fileUrl; String get status; String? get workerName;
/// Create a copy of WorkerDocumentAdminModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerDocumentAdminModelCopyWith<WorkerDocumentAdminModel> get copyWith => _$WorkerDocumentAdminModelCopyWithImpl<WorkerDocumentAdminModel>(this as WorkerDocumentAdminModel, _$identity);

  /// Serializes this WorkerDocumentAdminModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerDocumentAdminModel&&(identical(other.id, id) || other.id == id)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.workerName, workerName) || other.workerName == workerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,workerId,documentType,fileUrl,status,workerName);

@override
String toString() {
  return 'WorkerDocumentAdminModel(id: $id, workerId: $workerId, documentType: $documentType, fileUrl: $fileUrl, status: $status, workerName: $workerName)';
}


}

/// @nodoc
abstract mixin class $WorkerDocumentAdminModelCopyWith<$Res>  {
  factory $WorkerDocumentAdminModelCopyWith(WorkerDocumentAdminModel value, $Res Function(WorkerDocumentAdminModel) _then) = _$WorkerDocumentAdminModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'document_type') String documentType,@JsonKey(name: 'file_url') String fileUrl, String status, String? workerName
});




}
/// @nodoc
class _$WorkerDocumentAdminModelCopyWithImpl<$Res>
    implements $WorkerDocumentAdminModelCopyWith<$Res> {
  _$WorkerDocumentAdminModelCopyWithImpl(this._self, this._then);

  final WorkerDocumentAdminModel _self;
  final $Res Function(WorkerDocumentAdminModel) _then;

/// Create a copy of WorkerDocumentAdminModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? workerId = null,Object? documentType = null,Object? fileUrl = null,Object? status = null,Object? workerName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,workerName: freezed == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerDocumentAdminModel].
extension WorkerDocumentAdminModelPatterns on WorkerDocumentAdminModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerDocumentAdminModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerDocumentAdminModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerDocumentAdminModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'document_type')  String documentType, @JsonKey(name: 'file_url')  String fileUrl,  String status,  String? workerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel() when $default != null:
return $default(_that.id,_that.workerId,_that.documentType,_that.fileUrl,_that.status,_that.workerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'document_type')  String documentType, @JsonKey(name: 'file_url')  String fileUrl,  String status,  String? workerName)  $default,) {final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel():
return $default(_that.id,_that.workerId,_that.documentType,_that.fileUrl,_that.status,_that.workerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'document_type')  String documentType, @JsonKey(name: 'file_url')  String fileUrl,  String status,  String? workerName)?  $default,) {final _that = this;
switch (_that) {
case _WorkerDocumentAdminModel() when $default != null:
return $default(_that.id,_that.workerId,_that.documentType,_that.fileUrl,_that.status,_that.workerName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerDocumentAdminModel implements WorkerDocumentAdminModel {
  const _WorkerDocumentAdminModel({required this.id, @JsonKey(name: 'worker_id') required this.workerId, @JsonKey(name: 'document_type') required this.documentType, @JsonKey(name: 'file_url') required this.fileUrl, required this.status, this.workerName});
  factory _WorkerDocumentAdminModel.fromJson(Map<String, dynamic> json) => _$WorkerDocumentAdminModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'worker_id') final  String workerId;
@override@JsonKey(name: 'document_type') final  String documentType;
@override@JsonKey(name: 'file_url') final  String fileUrl;
@override final  String status;
@override final  String? workerName;

/// Create a copy of WorkerDocumentAdminModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerDocumentAdminModelCopyWith<_WorkerDocumentAdminModel> get copyWith => __$WorkerDocumentAdminModelCopyWithImpl<_WorkerDocumentAdminModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerDocumentAdminModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerDocumentAdminModel&&(identical(other.id, id) || other.id == id)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.workerName, workerName) || other.workerName == workerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,workerId,documentType,fileUrl,status,workerName);

@override
String toString() {
  return 'WorkerDocumentAdminModel(id: $id, workerId: $workerId, documentType: $documentType, fileUrl: $fileUrl, status: $status, workerName: $workerName)';
}


}

/// @nodoc
abstract mixin class _$WorkerDocumentAdminModelCopyWith<$Res> implements $WorkerDocumentAdminModelCopyWith<$Res> {
  factory _$WorkerDocumentAdminModelCopyWith(_WorkerDocumentAdminModel value, $Res Function(_WorkerDocumentAdminModel) _then) = __$WorkerDocumentAdminModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'document_type') String documentType,@JsonKey(name: 'file_url') String fileUrl, String status, String? workerName
});




}
/// @nodoc
class __$WorkerDocumentAdminModelCopyWithImpl<$Res>
    implements _$WorkerDocumentAdminModelCopyWith<$Res> {
  __$WorkerDocumentAdminModelCopyWithImpl(this._self, this._then);

  final _WorkerDocumentAdminModel _self;
  final $Res Function(_WorkerDocumentAdminModel) _then;

/// Create a copy of WorkerDocumentAdminModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? workerId = null,Object? documentType = null,Object? fileUrl = null,Object? status = null,Object? workerName = freezed,}) {
  return _then(_WorkerDocumentAdminModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,workerName: freezed == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
