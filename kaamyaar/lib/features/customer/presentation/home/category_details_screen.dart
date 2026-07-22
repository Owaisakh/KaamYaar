import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryId;
  const CategoryDetailsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final title = categoryId.toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('$title Services'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Category Info Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.customerPrimary, Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.customerAccent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.build_rounded, color: AppColors.customerAccent, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title Professional Care',
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Verified, background-checked pros near you.',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Popular Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
            const SizedBox(height: 12),

            _buildServiceItem(
              title: 'Pipe Leakage Repair',
              estPrice: 'Rs. 500',
              estTime: '30 - 45 mins',
              rating: '4.8 (210+ reviews)',
            ),
            _buildServiceItem(
              title: 'Faucet & Tap Installation',
              estPrice: 'Rs. 400',
              estTime: '20 - 30 mins',
              rating: '4.9 (180+ reviews)',
            ),
            _buildServiceItem(
              title: 'Drainage Unclogging',
              estPrice: 'Rs. 800',
              estTime: '45 - 60 mins',
              rating: '4.7 (140+ reviews)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required String title,
    required String estPrice,
    required String estTime,
    required String rating,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, size: 14, color: AppColors.textSecondaryLight),
                      const SizedBox(width: 4),
                      Text(estTime, style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                      const SizedBox(width: 12),
                      const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(estPrice, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerAccent)),
                const SizedBox(height: 4),
                const KaamYaarBadge(label: 'Starting', type: KaamYaarBadgeType.info),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
