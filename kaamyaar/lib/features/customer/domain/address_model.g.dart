// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      label: json['label'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'label': instance.label,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_default': instance.isDefault,
    };
