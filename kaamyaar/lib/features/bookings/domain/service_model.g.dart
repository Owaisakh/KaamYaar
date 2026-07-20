// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    _ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      basePrice: (json['basePrice'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ServiceModelToJson(_ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
      'description': instance.description,
      'basePrice': instance.basePrice,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
    };
