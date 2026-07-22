import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_button.dart';

class MatchingRadarScreen extends StatefulWidget {
  const MatchingRadarScreen({super.key});

  @override
  State<MatchingRadarScreen> createState() => _MatchingRadarScreenState();
}

class _MatchingRadarScreenState extends State<MatchingRadarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customerPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Radar pulse animation
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 240 * _controller.value,
                        height: 240 * _controller.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.customerAccent.withValues(alpha: 0.3 * (1 - _controller.value)),
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.customerAccent.withValues(alpha: 0.2),
                          border: Border.all(color: AppColors.customerAccent, width: 2),
                        ),
                        child: const Icon(Icons.radar_rounded, size: 60, color: AppColors.customerAccent),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 48),

              const Text(
                'Finding Nearby Experts...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Broadcasting your request to 5 verified pros near DHA Phase 2, Lahore',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.4),
              ),
              const Spacer(),

              KaamYaarButton(
                label: 'Cancel Search',
                type: KaamYaarButtonType.outline,
                customColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
