import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/payment_model.dart';

part 'payment_repository.g.dart';

class PaymentRepository {
  final SupabaseClient _client;

  PaymentRepository(this._client);

  Future<PaymentModel> createPayment({
    required String bookingId,
    required double amount,
    String method = 'cash',
  }) async {
    final response = await _client.from('payments').insert({
      'booking_id': bookingId,
      'amount': amount,
      'method': method,
      'status': 'pending', // cash pending until confirmed
    }).select().single();

    return PaymentModel.fromJson(response);
  }

  Future<PaymentModel?> getPaymentForBooking(String bookingId) async {
    final response = await _client
        .from('payments')
        .select()
        .eq('booking_id', bookingId)
        .maybeSingle();
        
    if (response == null) return null;
    return PaymentModel.fromJson(response);
  }

  Future<void> markPaymentSuccess(String paymentId) async {
    await _client
        .from('payments')
        .update({
          'status': 'success',
          'paid_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', paymentId);
  }
}

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(Supabase.instance.client);
}
