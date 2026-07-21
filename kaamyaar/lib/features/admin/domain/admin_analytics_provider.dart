import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/supabase/supabase_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_analytics_provider.freezed.dart';
part 'admin_analytics_provider.g.dart';

@freezed
abstract class AdminAnalyticsState with _$AdminAnalyticsState {
  const factory AdminAnalyticsState({
    @Default(0) int activeBookings,
    @Default(0.0) double totalRevenue,
  }) = _AdminAnalyticsState;
}

@riverpod
class AdminAnalytics extends _$AdminAnalytics {
  @override
  Future<AdminAnalyticsState> build() async {
    final supabase = ref.watch(supabaseClientProvider);
    
    // Fetch active bookings count
    final activeBookingsRes = await supabase
        .from('bookings')
        .select('id')
        .inFilter('status', [
          'pending', 'assigned', 'accepted', 
          'on_the_way', 'arrived', 'in_progress'
        ]);
        
    final activeCount = (activeBookingsRes as List).length;

    // Fetch total revenue
    final paymentsRes = await supabase
        .from('payments')
        .select('amount')
        .eq('status', 'success');
        
    double revenue = 0.0;
    for (var payment in (paymentsRes as List)) {
      revenue += (payment['amount'] as num).toDouble();
    }

    return AdminAnalyticsState(
      activeBookings: activeCount,
      totalRevenue: revenue,
    );
  }
}
