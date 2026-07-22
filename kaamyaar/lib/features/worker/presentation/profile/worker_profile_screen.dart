import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_avatar.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';
import '../../../../core/supabase/auth_provider.dart';

class WorkerProfileScreen extends ConsumerWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Partner Profile'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          KaamYaarCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                KaamYaarAvatar(
                  name: user?.name ?? 'Ali Hassan',
                  radius: 32,
                  isVerified: true,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? 'Ali Hassan', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.workerSecondary)),
                      const SizedBox(height: 2),
                      const Text('Master Plumber • Verified Partner', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                      const SizedBox(height: 8),
                      const KaamYaarBadge(label: '4.9 ★ (240 Jobs)', type: KaamYaarBadgeType.success),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text('Partner Management', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.workerSecondary)),
          const SizedBox(height: 12),

          _buildTile(
            icon: Icons.handyman_rounded,
            title: 'My Skills & Categories',
            subtitle: 'Plumbing, Faucet installation, Leakage',
            onTap: () => context.push('/worker/skills'),
          ),
          _buildTile(
            icon: Icons.verified_user_rounded,
            title: 'Document Verification Status',
            subtitle: 'CNIC & Skill Certificate Verified',
            onTap: () => context.push('/worker/verification'),
          ),
          _buildTile(
            icon: Icons.account_balance_wallet_rounded,
            title: 'Payout Accounts',
            subtitle: 'EasyPaisa: +92 300 1234567',
            onTap: () => context.push('/worker/wallet'),
          ),
          _buildTile(
            icon: Icons.star_rounded,
            title: 'Customer Ratings & Reviews',
            subtitle: 'Read 240+ verified customer feedbacks',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          OutlinedButton.icon(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) context.go('/login');
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            label: const Text('Log Out Partner Account', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              side: const BorderSide(color: AppColors.error),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.workerPrimary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.workerPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondaryLight),
          ],
        ),
      ),
    );
  }
}
