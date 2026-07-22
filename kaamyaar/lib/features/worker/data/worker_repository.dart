import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../bookings/domain/booking_model.dart';
import '../../auth/domain/user_model.dart';

part 'worker_repository.g.dart';

class WorkerProfile {
  final String id;
  final String userId;
  final String serviceId;
  final bool isOnline;
  final int completedJobs;
  final double rating;

  WorkerProfile({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.isOnline,
    required this.completedJobs,
    required this.rating,
  });

  factory WorkerProfile.fromJson(Map<String, dynamic> json) {
    return WorkerProfile(
      id: json['id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      isOnline: json['online_status'] ?? false,
      completedJobs: json['completed_jobs'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }
}

class WorkerRepository {
  final SupabaseClient _supabase;

  WorkerRepository(this._supabase);

  Future<WorkerProfile?> getWorkerProfileByUserId(String userId) async {
    final response = await _supabase
        .from('workers')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
        
    if (response == null) return null;
    return WorkerProfile.fromJson(response);
  }

  Future<void> toggleOnlineStatus(String workerId, bool isOnline) async {
    await _supabase
        .from('workers')
        .update({'online_status': isOnline})
        .eq('id', workerId);
  }

  Future<double> getWorkerEarnings(String workerId) async {
    final response = await _supabase
        .from('bookings')
        .select('final_price')
        .eq('worker_id', workerId)
        .eq('status', 'completed');
        
    double total = 0.0;
    for (var row in response) {
      final price = row['final_price'];
      if (price != null) {
        total += (price as num).toDouble();
      }
    }
    return total;
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _supabase
        .from('bookings')
        .update({'status': status})
        .eq('id', bookingId);
  }

  Future<void> broadcastLocation({
    required String workerId,
    required double latitude,
    required double longitude,
    required double accuracy,
    String? bookingId,
  }) async {
    final payload = {
      'worker_id': workerId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
    };
    if (bookingId != null) {
      payload['booking_id'] = bookingId;
    }
    
    // Check if a record already exists for this worker
    final existing = await _supabase
        .from('worker_location')
        .select('id')
        .eq('worker_id', workerId)
        .maybeSingle();

    if (existing != null) {
      await _supabase
          .from('worker_location')
          .update(payload)
          .eq('id', existing['id']);
    } else {
      await _supabase
          .from('worker_location')
          .insert(payload);
    }
  }

  Stream<List<BookingModel>> watchAssignedBookings(String workerId) {
    return _supabase
        .from('bookings')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .where((json) => json['worker_id'] == workerId)
            .map((json) => BookingModel.fromJson(json))
            .toList());
  }
  
  Stream<List<BookingModel>> watchPendingBookingsByService(String serviceId) {
    return _supabase
        .from('bookings')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .where((json) => json['service_id'] == serviceId && json['status'] == 'pending')
            .map((json) => BookingModel.fromJson(json))
            .toList());
  }
}

@riverpod
WorkerRepository workerRepository(Ref ref) {
  return WorkerRepository(Supabase.instance.client);
}
