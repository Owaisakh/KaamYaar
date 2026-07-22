import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'kaamyaar_button.dart';

class KaamYaarEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const KaamYaarEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.customerAccent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColors.customerAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.customerPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryLight,
                height: 1.4,
              ),
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 24),
              KaamYaarButton(
                label: actionLabel!,
                onPressed: onActionPressed,
                width: 200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
