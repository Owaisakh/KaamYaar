import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum KaamYaarBadgeType { success, warning, error, info, neutral }

class KaamYaarBadge extends StatelessWidget {
  final String label;
  final KaamYaarBadgeType type;
  final IconData? icon;

  const KaamYaarBadge({
    super.key,
    required this.label,
    this.type = KaamYaarBadgeType.neutral,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color border;

    switch (type) {
      case KaamYaarBadgeType.success:
        bg = const Color(0xFFECFDF5);
        fg = AppColors.success;
        border = const Color(0xFFA7F3D0);
        break;
      case KaamYaarBadgeType.warning:
        bg = const Color(0xFFFFFBEB);
        fg = AppColors.warning;
        border = const Color(0xFFFDE68A);
        break;
      case KaamYaarBadgeType.error:
        bg = const Color(0xFFFEF2F2);
        fg = AppColors.error;
        border = const Color(0xFFFECACA);
        break;
      case KaamYaarBadgeType.info:
        bg = const Color(0xFFEFF6FF);
        fg = AppColors.info;
        border = const Color(0xFFBFDBFE);
        break;
      case KaamYaarBadgeType.neutral:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
        border = const Color(0xFFE2E8F0);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
