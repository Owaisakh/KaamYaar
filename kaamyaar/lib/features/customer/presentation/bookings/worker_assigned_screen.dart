import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_avatar.dart';
import '../../../../core/widgets/kaamyaar_button.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';

class WorkerAssignedScreen extends StatelessWidget {
  const WorkerAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Worker Assigned'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    const KaamYaarAvatar(
                      name: 'Ali Hassan',
                      radius: 40,
                      isVerified: true,
                    ),
                    const SizedBox(height: 16),
                    const Text('Ali Hassan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                    const SizedBox(height: 4),
                    const Text('Master Plumber • 5+ Yrs Exp', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 20),
                        SizedBox(width: 4),
                        Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 6),
                        Text('(240 jobs completed)', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const KaamYaarBadge(label: 'ETA: 8 mins away', type: KaamYaarBadgeType.success, icon: Icons.navigation_rounded),
                  ],
                ),
              ),
              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.call_rounded, color: AppColors.customerPrimary),
                      label: const Text('Call Worker', style: TextStyle(color: AppColors.customerPrimary, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.borderLight),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_rounded, color: Colors.white),
                      label: const Text('Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customerAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              KaamYaarButton(
                label: 'Live Track Worker',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
