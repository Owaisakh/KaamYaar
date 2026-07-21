// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  phone: json['phone'] as String,
  name: json['name'] as String?,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'role': _$UserRoleEnumMap[instance.role],
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.worker: 'worker',
  UserRole.admin: 'admin',
};
