import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class KaamYaarAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double radius;
  final bool isOnline;
  final bool isVerified;
  final Color? backgroundColor;

  const KaamYaarAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.radius = 24.0,
    this.isOnline = false,
    this.isVerified = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final initials = (name != null && name!.trim().isNotEmpty)
        ? name!.trim().split(' ').map((e) => e[0]).take(2).join('').toUpperCase()
        : 'KY';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor ?? AppColors.customerAccent.withValues(alpha: 0.15),
          backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!)
              : null,
          child: (imageUrl == null || imageUrl!.isEmpty)
              ? Text(
                  initials,
                  style: TextStyle(
                    fontSize: radius * 0.75,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customerPrimary,
                  ),
                )
              : null,
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.6,
              height: radius * 0.6,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        if (isVerified && !isOnline)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: radius * 0.5,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
