import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/worker_repository.dart';
import '../../../../core/services/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../bookings/data/payment_repository.dart';

part 'active_job_controller.g.dart';

@riverpod
class ActiveJobController extends _$ActiveJobController {
  StreamSubscription<Position>? _locationSubscription;
  String? _currentBookingId;

  @override
  bool build() {
    ref.onDispose(() {
      _locationSubscription?.cancel();
    });
    return false; // represents if we are broadcasting location
  }

  Future<void> startLocationBroadcast(String workerId, String bookingId) async {
    _currentBookingId = bookingId;
    final locService = ref.read(locationServiceProvider);
    
    final hasPermission = await locService.handleLocationPermission();
    if (!hasPermission) return;

    final stream = locService.getPositionStream();
    _locationSubscription = stream.listen((Position position) {
      ref.read(workerRepositoryProvider).broadcastLocation(
        workerId: workerId,
        bookingId: bookingId,
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
      );
    });
    state = true;
  }

  void stopLocationBroadcast() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    state = false;
  }

  Future<void> updateJobStatus(String bookingId, String newStatus, {dynamic booking}) async {
    await ref.read(workerRepositoryProvider).updateBookingStatus(bookingId, newStatus);
    
    if (newStatus == 'completed' && booking != null) {
      try {
        final paymentRepo = ref.read(paymentRepositoryProvider);
        final existingPayment = await paymentRepo.getPaymentForBooking(bookingId);
        if (existingPayment == null) {
          await paymentRepo.createPayment(
            bookingId: bookingId,
            amount: booking.finalPrice ?? booking.estimatedPrice ?? 0.0,
            method: 'cash',
          );
        }
      } catch (e) {
        print('Error creating payment record: $e');
      }
    }
    
    // Manage location broadcasting based on status
    if (newStatus == 'arrived' || newStatus == 'completed' || newStatus == 'cancelled') {
      stopLocationBroadcast();
    }
  }
}
