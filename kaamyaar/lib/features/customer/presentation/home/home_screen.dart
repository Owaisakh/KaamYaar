import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/supabase/auth_provider.dart';
import '../../../bookings/data/service_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authNotifierProvider);
    final servicesAsync = ref.watch(activeServicesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              title: userAsync.when(
                data: (user) => Text(
                  'Hi, ${user?.name?.split(' ').first ?? 'Guest'} 👋',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                loading: () => const Text('Loading...'),
                error: (_, __) => const Text('Welcome!'),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.bell),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  context.push('/service-search');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.search, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Text(
                        'What do you need help with?',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Emergency Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Service',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Get a pro at your door in 30 mins.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Handle emergency booking
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFDC2626),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      LucideIcons.alertTriangle,
                      size: 64,
                      color: Colors.white24,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Services Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Our Services',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Services Grid
          servicesAsync.when(
            data: (services) {
              if (services.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No services available right now.'),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final service = services[index];
                      return GestureDetector(
                        onTap: () {
                          context.push('/book-service', extra: service);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.shadowColor.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getIconForSlug(service.slug),
                                  color: theme.colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                service.name,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: services.length,
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (error, _) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('Error loading services: $error'),
                ),
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  IconData _getIconForSlug(String slug) {
    switch (slug) {
      case 'plumber':
        return LucideIcons.wrench;
      case 'electrician':
        return LucideIcons.zap;
      case 'ac_repair':
        return LucideIcons.snowflake;
      case 'cleaner':
        return LucideIcons.sparkles;
      case 'carpenter':
        return LucideIcons.hammer;
      case 'painter':
        return LucideIcons.paintbrush;
      default:
        return LucideIcons.tool;
    }
  }
}
