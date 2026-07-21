import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/review_model.dart';

part 'review_repository.g.dart';

class ReviewRepository {
  final SupabaseClient _client;

  ReviewRepository(this._client);

  Future<ReviewModel> createReview({
    required String bookingId,
    required String customerId,
    required String workerId,
    required int rating,
    String? review,
  }) async {
    final response = await _client.from('reviews').insert({
      'booking_id': bookingId,
      'customer_id': customerId,
      'worker_id': workerId,
      'rating': rating,
      'review': review,
    }).select().single();

    return ReviewModel.fromJson(response);
  }

  Future<List<ReviewModel>> getWorkerReviews(String workerId) async {
    final response = await _client
        .from('reviews')
        .select()
        .eq('worker_id', workerId)
        .order('created_at', ascending: false);
        
    return (response as List<dynamic>)
        .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
ReviewRepository reviewRepository(Ref ref) {
  return ReviewRepository(Supabase.instance.client);
}
