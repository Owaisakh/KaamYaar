import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Worker Accepted Request',
        'subtitle': 'Ali Hassan has accepted your Plumbing request.',
        'time': '10 mins ago',
        'type': 'booking',
      },
      {
        'title': '20% OFF Promo Applied!',
        'subtitle': 'Use promo code KAAM20 for your next AC servicing.',
        'time': '2 hours ago',
        'type': 'promo',
      },
      {
        'title': 'Job Completed',
        'subtitle': 'Your Electrical repair job is completed. Please leave a rating.',
        'time': 'Yesterday',
        'type': 'completed',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: KaamYaarCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.customerAccent.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['type'] == 'promo' ? Icons.local_offer_rounded : Icons.notifications_rounded,
                      color: AppColors.customerAccent,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Text(item['subtitle']!, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(item['time']!, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
