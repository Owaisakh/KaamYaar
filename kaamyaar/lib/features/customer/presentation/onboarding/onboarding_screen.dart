import 'package:flutter/material.dart';
import '../../../../core/widgets/kaamyaar_button.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Find Trusted Professionals',
      'subtitle': 'Book verified plumbers, electricians, cleaners & home experts instantly at your doorstep.',
    },
    {
      'title': 'Instant & Scheduled Booking',
      'subtitle': 'Choose 24/7 emergency dispatch or schedule a convenient time slot for your service.',
    },
    {
      'title': 'Realtime GPS Live Tracking',
      'subtitle': 'Watch your assigned worker arrive in real-time on Google Maps with precise ETA.',
    },
    {
      'title': 'Safe & Flexible Payments',
      'subtitle': 'Pay hassle-free via Cash on completion, EasyPaisa, JazzCash, or Debit/Credit Cards.',
    },
    {
      'title': 'Verified Ratings & Reviews',
      'subtitle': 'Read genuine customer reviews, check ratings, and hire the top rated pros nearby.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
            child: const Text('Skip', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.customerAccent.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getSlideIcon(index),
                            size: 60,
                            color: AppColors.customerAccent,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.customerPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF64748B),
                            height: 1.4,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.customerAccent : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              KaamYaarButton(
                label: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  } else {
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSlideIcon(int index) {
    switch (index) {
      case 0: return Icons.verified_user_rounded;
      case 1: return Icons.bolt_rounded;
      case 2: return Icons.location_on_rounded;
      case 3: return Icons.payments_rounded;
      case 4: return Icons.star_rounded;
      default: return Icons.handyman_rounded;
    }
  }
}
