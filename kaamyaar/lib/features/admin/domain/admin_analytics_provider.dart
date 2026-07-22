import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/supabase/supabase_config.dart';

part 'admin_analytics_provider.g.dart';

class AdminAnalyticsState {
  final int activeBookings;
  final double totalRevenue;

  AdminAnalyticsState({required this.activeBookings, required this.totalRevenue});
}

@riverpod
class AdminAnalytics extends _$AdminAnalytics {
  @override
  Future<AdminAnalyticsState> build() async {
    final supabase = SupabaseConfig.client;
    
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
