import 'package:flutter/material.dart';

class KaamYaarSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const KaamYaarSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12.0,
  });

  @override
  State<KaamYaarSkeleton> createState() => _KaamYaarSkeletonState();
}

class _KaamYaarSkeletonState extends State<KaamYaarSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}
