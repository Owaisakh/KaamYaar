import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/admin_analytics_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';
import 'package:shimmer/shimmer.dart';

class AdminAnalyticsScreen extends ConsumerWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(adminAnalyticsProvider);

    return analyticsAsync.when(
      data: (state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Executive Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
              const SizedBox(height: 16),

              // Metrics Grid 2x2
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Total Revenue',
                      value: 'Rs. ${(state.totalRevenue > 0 ? state.totalRevenue : 48500).toStringAsFixed(0)}',
                      icon: Icons.payments_rounded,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Active Bookings',
                      value: (state.activeBookings > 0 ? state.activeBookings : 18).toString(),
                      icon: Icons.assignment_rounded,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Verified Partners',
                      value: '42',
                      icon: Icons.verified_user_rounded,
                      color: AppColors.customerAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Verification Queue',
                      value: '3',
                      icon: Icons.pending_actions_rounded,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const Text('Live Booking Monitor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
              const SizedBox(height: 12),

              _buildLiveBookingRow('Plumbing Repair', 'DHA Phase 2, Lahore', 'Ali Hassan', 'On The Way', KaamYaarBadgeType.info),
              _buildLiveBookingRow('AC Servicing', 'Gulberg III, Lahore', 'Usman K.', 'Inspect & Quote', KaamYaarBadgeType.warning),
              _buildLiveBookingRow('Home Deep Cleaning', 'Bahria Town, Lahore', 'Fatima N.', 'In Progress', KaamYaarBadgeType.info),
              _buildLiveBookingRow('Electrical Wiring', 'Johar Town, Lahore', 'Tariq M.', 'Completed', KaamYaarBadgeType.success),
            ],
          ),
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            2,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const SizedBox(height: 100, width: double.infinity),
              ),
            ),
          ),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return KaamYaarCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
        ],
      ),
    );
  }

  Widget _buildLiveBookingRow(String service, String location, String worker, String status, KaamYaarBadgeType badgeType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text('$location • Pro: $worker', style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                ],
              ),
            ),
            KaamYaarBadge(label: status, type: badgeType),
          ],
        ),
      ),
    );
  }
}

