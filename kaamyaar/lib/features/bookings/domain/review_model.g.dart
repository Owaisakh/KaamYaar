// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: json['id'] as String,
  bookingId: json['booking_id'] as String,
  customerId: json['customer_id'] as String,
  workerId: json['worker_id'] as String,
  rating: (json['rating'] as num).toInt(),
  review: json['review'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'customer_id': instance.customerId,
      'worker_id': instance.workerId,
      'rating': instance.rating,
      'review': instance.review,
      'created_at': instance.createdAt?.toIso8601String(),
    };
