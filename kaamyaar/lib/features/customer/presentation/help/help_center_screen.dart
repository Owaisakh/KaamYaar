import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          KaamYaarCard(
            backgroundColor: AppColors.customerPrimary,
            child: Row(
              children: [
                const Icon(Icons.support_agent_rounded, color: AppColors.customerAccent, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Live Support 24/7', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Chat with our customer service team anytime.', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Frequently Asked Questions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
          const SizedBox(height: 12),
          _buildFaqItem('How do I pay for a completed service?', 'You can pay via Cash, EasyPaisa, JazzCash, or Debit/Credit Card on the payment screen after job completion.'),
          _buildFaqItem('Are all workers background checked?', 'Yes! Every worker undergoes CNIC document verification and background check before receiving jobs.'),
          _buildFaqItem('Can I cancel a booking?', 'Yes, you can cancel any booking before the worker arrives at your location.'),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: ExpansionTile(
          title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.customerPrimary)),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(answer, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 14, height: 1.4)),
            ),
          ],
        ),
      ),
    );
  }
}
