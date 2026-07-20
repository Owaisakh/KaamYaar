// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      workerId: json['worker_id'] as String?,
      serviceId: json['service_id'] as String,
      addressId: json['address_id'] as String,
      problemDescription: json['problem_description'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      estimatedPrice: (json['estimated_price'] as num?)?.toDouble(),
      finalPrice: (json['final_price'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'worker_id': instance.workerId,
      'service_id': instance.serviceId,
      'address_id': instance.addressId,
      'problem_description': instance.problemDescription,
      'scheduled_time': instance.scheduledTime.toIso8601String(),
      'estimated_price': instance.estimatedPrice,
      'final_price': instance.finalPrice,
      'status': instance.status,
    };
