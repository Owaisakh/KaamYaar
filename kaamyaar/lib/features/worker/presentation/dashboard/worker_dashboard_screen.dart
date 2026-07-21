import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/supabase/auth_provider.dart';
import '../../data/worker_repository.dart';
import '../jobs/incoming_job_alert.dart';
import '../../../../core/theme/app_colors.dart';
import '../bookings/worker_bookings_screen.dart';

final workerProfileProvider = FutureProvider<WorkerProfile?>((ref) async {
  final user = ref.watch(authProvider).value;
  if (user == null) return null;
  final repo = ref.read(workerRepositoryProvider);
  return repo.getWorkerProfileByUserId(user.id);
});

final workerEarningsProvider = FutureProvider<double>((ref) async {
  final profile = await ref.watch(workerProfileProvider.future);
  if (profile == null) return 0.0;
  final repo = ref.read(workerRepositoryProvider);
  return repo.getWorkerEarnings(profile.id);
});

final onlineStatusProvider = StateProvider<bool>((ref) => false);

class WorkerDashboardScreen extends ConsumerStatefulWidget {
  const WorkerDashboardScreen({super.key});

  @override
  ConsumerState<WorkerDashboardScreen> createState() => _WorkerDashboardScreenState();
}

class _WorkerDashboardScreenState extends ConsumerState<WorkerDashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the online status from the DB profile
    Future.microtask(() async {
      final profile = await ref.read(workerProfileProvider.future);
      if (profile != null) {
        ref.read(onlineStatusProvider.notifier).state = profile.isOnline;
      }
    });
  }

  void _toggleOnlineStatus(bool value) async {
    ref.read(onlineStatusProvider.notifier).state = value;
    final profile = await ref.read(workerProfileProvider.future);
    if (profile != null) {
      await ref.read(workerRepositoryProvider).toggleOnlineStatus(profile.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authProvider);
    final profileAsync = ref.watch(workerProfileProvider);
    final earningsAsync = ref.watch(workerEarningsProvider);
    final isOnline = ref.watch(onlineStatusProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: userAsync.when(
          data: (user) => Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryPurple.withOpacity(0.2),
                child: const Icon(Icons.person, color: AppColors.primaryPurple),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Good Morning,', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(user?.name ?? 'Worker', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ],
          ),
          loading: () => const SizedBox(),
          error: (_, __) => const SizedBox(),
        ),
      ),
      body: [
        _buildHomeDashboard(profileAsync, earningsAsync, isOnline),
        const WorkerBookingsScreen(),
        const Center(child: Text('Earnings Details coming soon')),
        const Center(child: Text('Profile coming soon')),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: AppColors.primaryPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeDashboard(AsyncValue profileAsync, AsyncValue earningsAsync, bool isOnline) {
    return profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading profile: $e')),
        data: (profile) {
          if (profile == null) return const Center(child: Text('Worker profile not found.'));
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(workerProfileProvider);
              ref.invalidate(workerEarningsProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Online Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: isOnline ? AppColors.success : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isOnline ? 'You are Online' : 'You are Offline',
                          style: TextStyle(
                            color: isOnline ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: isOnline,
                          onChanged: _toggleOnlineStatus,
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.success,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Today's Earnings", style: TextStyle(color: Colors.grey, fontSize: 14)),
                              const SizedBox(height: 8),
                              earningsAsync.when(
                                data: (earnings) => Text('Rs. ${earnings.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                loading: () => const CircularProgressIndicator(),
                                error: (_, __) => const Text('Error'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Jobs Completed", style: TextStyle(color: Colors.grey, fontSize: 14)),
                              const SizedBox(height: 8),
                              Text('${profile.completedJobs}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // New Requests Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Today's Jobs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("2 New Requests", style: TextStyle(fontSize: 14, color: AppColors.primaryPurple, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Jobs Stream
                  IncomingJobsList(serviceId: profile.serviceId),
                ],
              ),
            ),
          );
        },
      );
  }
}
