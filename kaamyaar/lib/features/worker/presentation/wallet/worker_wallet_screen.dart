import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_button.dart';

class WorkerWalletScreen extends StatelessWidget {
  const WorkerWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('My Wallet & Payouts'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.workerPrimary, AppColors.workerDarkTeal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                const Text('Rs. 12,450', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                KaamYaarButton(
                  label: 'Withdraw Funds',
                  type: KaamYaarButtonType.outline,
                  customColor: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Recent Payout History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
          const SizedBox(height: 12),
          _buildPayoutRow('EasyPaisa Transfer', 'Rs. 4,500', '22 Jul 2026', 'Success'),
          _buildPayoutRow('Bank Withdrawal', 'Rs. 8,000', '15 Jul 2026', 'Success'),
        ],
      ),
    );
  }

  Widget _buildPayoutRow(String title, String amount, String date, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
              ],
            ),
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.success)),
          ],
        ),
      ),
    );
  }
}
