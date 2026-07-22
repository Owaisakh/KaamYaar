import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_avatar.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/supabase/auth_provider.dart';

class CustomerProfileScreen extends ConsumerWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Card
          KaamYaarCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                KaamYaarAvatar(
                  name: user?.name ?? 'Customer User',
                  radius: 32,
                  isVerified: true,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? 'Customer User', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                      const SizedBox(height: 4),
                      Text(user?.phone ?? '+92 300 1234567', style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_rounded, color: AppColors.customerAccent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text('Account Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
          const SizedBox(height: 12),

          _buildProfileTile(
            icon: Icons.location_on_rounded,
            title: 'Saved Addresses',
            subtitle: 'Home, Office, DHA Phase 2',
            onTap: () => context.push('/location-setup'),
          ),
          _buildProfileTile(
            icon: Icons.payment_rounded,
            title: 'Payment Methods',
            subtitle: 'Cash, EasyPaisa, JazzCash, Cards',
            onTap: () {},
          ),
          _buildProfileTile(
            icon: Icons.notifications_rounded,
            title: 'Notification Settings',
            subtitle: 'Manage promos and job updates',
            onTap: () => context.push('/settings'),
          ),
          _buildProfileTile(
            icon: Icons.support_agent_rounded,
            title: 'Help & Customer Support',
            subtitle: '24/7 Live chat and FAQs',
            onTap: () => context.push('/help'),
          ),
          _buildProfileTile(
            icon: Icons.settings_rounded,
            title: 'App Settings',
            subtitle: 'Biometrics, Language (English/Urdu)',
            onTap: () => context.push('/settings'),
          ),

          const SizedBox(height: 24),

          // Logout Button
          OutlinedButton.icon(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) context.go('/login');
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            label: const Text('Log Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
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

  Widget _buildProfileTile({
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
                color: AppColors.customerAccent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.customerAccent, size: 20),
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
