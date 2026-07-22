import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum KaamYaarButtonType { primary, secondary, outline, danger }

class KaamYaarButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final KaamYaarButtonType type;
  final double height;
  final double? width;
  final Color? customColor;

  const KaamYaarButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.type = KaamYaarButtonType.primary,
    this.height = 56.0,
    this.width,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (type) {
      case KaamYaarButtonType.primary:
        bg = customColor ?? AppColors.customerPrimary;
        fg = Colors.white;
        break;
      case KaamYaarButtonType.secondary:
        bg = customColor ?? AppColors.customerAccent;
        fg = Colors.white;
        break;
      case KaamYaarButtonType.outline:
        bg = Colors.transparent;
        fg = customColor ?? AppColors.customerPrimary;
        border = BorderSide(color: customColor ?? AppColors.borderLight, width: 1.5);
        break;
      case KaamYaarButtonType.danger:
        bg = AppColors.error;
        fg = Colors.white;
        break;
    }

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: type == KaamYaarButtonType.outline ? 0 : 2,
          shadowColor: bg.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: border,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(color: fg, strokeWidth: 2.5),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: fg),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fg,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
