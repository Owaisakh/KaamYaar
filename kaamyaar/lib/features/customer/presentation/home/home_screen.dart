import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/supabase/auth_provider.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_avatar.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> _allCategories = const [
    {'name': 'Plumber', 'id': 'plumber', 'icon': Icons.plumbing_rounded, 'price': 'Rs. 500'},
    {'name': 'Electrician', 'id': 'electrician', 'icon': Icons.electrical_services_rounded, 'price': 'Rs. 600'},
    {'name': 'AC Repair', 'id': 'ac_repair', 'icon': Icons.ac_unit_rounded, 'price': 'Rs. 1,200'},
    {'name': 'Cleaner', 'id': 'cleaner', 'icon': Icons.cleaning_services_rounded, 'price': 'Rs. 800'},
    {'name': 'Carpenter', 'id': 'carpenter', 'icon': Icons.handyman_rounded, 'price': 'Rs. 700'},
    {'name': 'Painter', 'id': 'painter', 'icon': Icons.format_paint_rounded, 'price': 'Rs. 1,500'},
    {'name': 'Mechanic', 'id': 'mechanic', 'icon': Icons.build_rounded, 'price': 'Rs. 1,000'},
    {'name': 'Appliance', 'id': 'appliance_repair', 'icon': Icons.kitchen_rounded, 'price': 'Rs. 900'},
    {'name': 'Pest Control', 'id': 'pest_control', 'icon': Icons.pest_control_rounded, 'price': 'Rs. 2,000'},
    {'name': 'Movers', 'id': 'movers', 'icon': Icons.local_shipping_rounded, 'price': 'Rs. 3,500'},
    {'name': 'Computer', 'id': 'computer_repair', 'icon': Icons.computer_rounded, 'price': 'Rs. 1,000'},
  ];

  final List<Map<String, dynamic>> _popularWorkers = const [
    {
      'name': 'Ali Hassan',
      'skill': 'Plumbing Expert',
      'rating': '4.9',
      'jobs': '240+ jobs',
      'price': 'Rs. 500/hr',
    },
    {
      'name': 'Usman Khalid',
      'skill': 'AC Specialist',
      'rating': '4.8',
      'jobs': '180+ jobs',
      'price': 'Rs. 1,200/hr',
    },
    {
      'name': 'Tariq Mehmood',
      'skill': 'Electrician',
      'rating': '4.9',
      'jobs': '310+ jobs',
      'price': 'Rs. 600/hr',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 16,
        title: GestureDetector(
          onTap: () => context.push('/location-setup'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('LOCATION', style: TextStyle(fontSize: 10, color: AppColors.textSecondaryLight, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.customerAccent),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.location_on_rounded, color: AppColors.customerAccent, size: 16),
                  SizedBox(width: 4),
                  Text('DHA Phase 2, Lahore', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.customerPrimary),
            onPressed: () => context.push('/notifications'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Header & Search Bar
            userAsync.when(
              data: (user) => Text(
                'Hi, ${user?.name?.split(' ').first ?? 'Customer'} 👋\nNeed help at home?',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.customerPrimary,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
            const SizedBox(height: 16),

            // Search Trigger Container
            GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search_rounded, color: AppColors.textSecondaryLight),
                    SizedBox(width: 12),
                    Text('Search "Plumber", "AC Repair"...', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14)),
                    Spacer(),
                    Icon(Icons.tune_rounded, color: AppColors.customerAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 24/7 Emergency Service Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const KaamYaarBadge(label: '24/7 AVAILABLE', type: KaamYaarBadgeType.error),
                        const SizedBox(height: 10),
                        const Text(
                          'Emergency Services',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Get a pro at your door in 30 mins.',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () => context.push('/matching'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFFDC2626),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: const Text('Get Help Instant', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bolt_rounded, size: 72, color: Colors.white24),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Categories Section Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('All Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
                TextButton(
                  onPressed: () => context.push('/search'),
                  child: const Text('View All', style: TextStyle(color: AppColors.customerAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 11 Categories Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.82,
              ),
              itemCount: _allCategories.length,
              itemBuilder: (context, index) {
                final cat = _allCategories[index];
                return GestureDetector(
                  onTap: () => context.push('/category/${cat['id']}'),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(cat['icon'] as IconData, color: AppColors.customerAccent, size: 26),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat['name'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.customerPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 28),

            // Popular Workers Carousel Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Top Rated Pros Nearby', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _popularWorkers.length,
                itemBuilder: (context, index) {
                  final worker = _popularWorkers[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 14),
                    child: KaamYaarCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              KaamYaarAvatar(name: worker['name'], radius: 20, isVerified: true),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(worker['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                                    Text(worker['skill'], style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                              const SizedBox(width: 4),
                              Text(worker['rating'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 6),
                              Text('(${worker['jobs']})', style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 11)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(worker['price'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.customerAccent)),
                              const KaamYaarBadge(label: 'Available', type: KaamYaarBadgeType.success),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

