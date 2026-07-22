import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_button.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';
import '../../../../core/widgets/kaamyaar_avatar.dart';
import '../../../bookings/domain/service_model.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel? service;
  const ServiceDetailsScreen({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    final title = service?.name ?? 'Plumbing Expert Service';
    final price = service?.basePrice != null ? 'Rs. ${service!.basePrice.toStringAsFixed(0)}' : 'Rs. 500';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Hero Card
                  KaamYaarCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const KaamYaarAvatar(name: 'Ali Hassan', radius: 28, isVerified: true),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                                  const SizedBox(height: 2),
                                  const Text('Ali Hassan • Verified Master Pro', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                            SizedBox(width: 4),
                            Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Text('(240+ verified customer reviews)', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.customerAccent)),
                            const KaamYaarBadge(label: 'Upfront Pricing', type: KaamYaarBadgeType.success),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('Service Highlights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                  const SizedBox(height: 12),
                  _buildHighlightRow(Icons.verified_user_rounded, '100% Background Checked Professionals'),
                  _buildHighlightRow(Icons.timer_rounded, '30-Minute On-Time Guarantee'),
                  _buildHighlightRow(Icons.shield_rounded, '30-Day Service Warranty Cover'),
                  const SizedBox(height: 24),

                  const Text('Customer Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                  const SizedBox(height: 12),
                  _buildReviewCard('Usman R.', '5.0', 'Super fast service! Solved my kitchen pipe leak in less than 30 minutes.'),
                  _buildReviewCard('Hamza K.', '5.0', 'Very polite and professional. Highly recommended for any plumbing work.'),
                ],
              ),
            ),

            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Icon(Icons.chat_rounded, color: AppColors.customerPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: KaamYaarButton(
                      label: 'Book Service Now',
                      onPressed: () {
                        final mockService = service ?? const ServiceModel(id: 'plumbing-1', name: 'Plumber', slug: 'plumber', basePrice: 500);
                        context.push('/book-service', extra: mockService);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.customerAccent),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14, color: AppColors.customerPrimary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String author, String rating, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                    const SizedBox(width: 4),
                    Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(text, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 13, height: 1.3)),
          ],
        ),
      ),
    );
  }
}
