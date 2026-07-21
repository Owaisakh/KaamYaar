import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import '../domain/booking_model.dart';
import '../../customer/domain/address_model.dart';

part 'booking_repository.g.dart';

class BookingRepository {
  final SupabaseClient _client;

  BookingRepository(this._client);

  Future<BookingModel> createBooking({
    required String customerId,
    required String serviceId,
    required String addressId,
    required String problemDescription,
    required DateTime scheduledTime,
    File? photo,
  }) async {
    // 1. Insert booking
    final response = await _client.from('bookings').insert({
      'customer_id': customerId,
      'service_id': serviceId,
      'address_id': addressId,
      'problem_description': problemDescription,
      'scheduled_time': scheduledTime.toIso8601String(),
      'status': 'pending',
    }).select().single();

    final booking = BookingModel.fromJson(response);

    // 2. Upload photo if exists
    if (photo != null) {
      final fileName = '${booking.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _client.storage.from('booking-photos').upload(fileName, photo);
      final imageUrl = _client.storage.from('booking-photos').getPublicUrl(fileName);

      await _client.from('booking_photos').insert({
        'booking_id': booking.id,
        'image_url': imageUrl,
      });
    }

    return booking;
  }

  Future<AddressModel> saveAddress({
    required String userId,
    required String label,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _client.from('addresses').insert({
      'user_id': userId,
      'label': label,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    }).select().single();

    return AddressModel.fromJson(response);
  }

  Future<List<AddressModel>> getUserAddresses(String userId) async {
    final response = await _client
        .from('addresses')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Stream<BookingModel> watchBooking(String bookingId) {
    return _client
        .from('bookings')
        .stream(primaryKey: ['id'])
        .eq('id', bookingId)
        .map((events) {
      if (events.isEmpty) {
        throw Exception('Booking not found');
      }
      return BookingModel.fromJson(events.first);
    });
  }

  Stream<Map<String, dynamic>> watchWorkerLocation(String bookingId) {
    return _client
        .from('worker_location')
        .stream(primaryKey: ['id'])
        .eq('booking_id', bookingId)
        .map((events) {
      if (events.isEmpty) return {};
      // Get the latest one if multiple
      events.sort((a, b) {
        final dateA = DateTime.parse(a['recorded_at']);
        final dateB = DateTime.parse(b['recorded_at']);
        return dateB.compareTo(dateA); // descending
      });
      return events.first;
    });
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _client
        .from('bookings')
        .update({'status': status})
        .eq('id', bookingId);
  }
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  return BookingRepository(Supabase.instance.client);
}
