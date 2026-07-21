import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
abstract class BookingModel with _$BookingModel {
  const factory BookingModel({
    required String id,
    @JsonKey(name: 'customer_id') required String customerId,
    @JsonKey(name: 'worker_id') String? workerId,
    @JsonKey(name: 'service_id') required String serviceId,
    @JsonKey(name: 'address_id') required String addressId,
    @JsonKey(name: 'problem_description') required String problemDescription,
    @JsonKey(name: 'scheduled_time') required DateTime scheduledTime,
    @JsonKey(name: 'estimated_price') double? estimatedPrice,
    @JsonKey(name: 'final_price') double? finalPrice,
    @Default('pending') String status,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}
