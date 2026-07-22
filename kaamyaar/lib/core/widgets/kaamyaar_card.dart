import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class KaamYaarCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  const KaamYaarCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 20.0,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShadow = boxShadow ?? [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];

    final cardChild = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppColors.borderLight,
          width: 1.2,
        ),
        boxShadow: effectiveShadow,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardChild,
      );
    }

    return cardChild;
  }
}
