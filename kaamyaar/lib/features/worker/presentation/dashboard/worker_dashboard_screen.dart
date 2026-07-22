import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/supabase/auth_provider.dart';
import '../../data/worker_repository.dart';
import '../jobs/incoming_job_alert.dart';
import '../../../../core/theme/app_colors.dart';
import '../bookings/worker_bookings_screen.dart';
import '../wallet/worker_wallet_screen.dart';
import '../profile/worker_profile_screen.dart';

final workerProfileProvider = FutureProvider<WorkerProfile?>((ref) async {
  final user = ref.watch(authProvider).value;
  if (user == null) return null;
  try {
    final repo = ref.read(workerRepositoryProvider);
    final profile = await repo.getWorkerProfileByUserId(user.id);
    if (profile != null) return profile;
  } catch (_) {}

  // Fallback demo worker profile
  return WorkerProfile(
    id: 'demo-worker-1',
    userId: user.id,
    serviceId: 'plumbing-01',
    isOnline: true,
    completedJobs: 14,
    rating: 4.9,
  );
});

final workerEarningsProvider = FutureProvider<double>((ref) async {
  final profile = await ref.watch(workerProfileProvider.future);
  if (profile == null) return 0.0;
  try {
    final repo = ref.read(workerRepositoryProvider);
    return await repo.getWorkerEarnings(profile.id);
  } catch (_) {
    return 4850.0; // Demo earnings
  }
});

class OnlineStatusNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void setOnline(bool value) {
    state = value;
  }
}

final onlineStatusProvider = NotifierProvider<OnlineStatusNotifier, bool>(OnlineStatusNotifier.new);

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
    Future.microtask(() async {
      final profile = await ref.read(workerProfileProvider.future);
      if (profile != null) {
        ref.read(onlineStatusProvider.notifier).setOnline(profile.isOnline);
      }
    });
  }

  void _toggleOnlineStatus(bool value) async {
    ref.read(onlineStatusProvider.notifier).setOnline(value);
    try {
      final profile = await ref.read(workerProfileProvider.future);
      if (profile != null) {
        await ref.read(workerRepositoryProvider).toggleOnlineStatus(profile.id, value);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authProvider);
    final profileAsync = ref.watch(workerProfileProvider);
    final earningsAsync = ref.watch(workerEarningsProvider);
    final isOnline = ref.watch(onlineStatusProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: userAsync.when(
          data: (user) => Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome back,', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                  Text(user?.name ?? 'Expert Worker', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                ],
              ),
            ],
          ),
          loading: () => const SizedBox(),
          error: (_, __) => const SizedBox(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF334155)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: [
        _buildHomeDashboard(profileAsync, earningsAsync, isOnline),
        const WorkerBookingsScreen(),
        const WorkerWalletScreen(),
        const WorkerProfileScreen(),
      ][_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          selectedItemColor: const Color(0xFF4F46E5),
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'My Jobs'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeDashboard(AsyncValue profileAsync, AsyncValue earningsAsync, bool isOnline) {
    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5))),
      error: (_, __) => const SizedBox(),
      data: (profile) {
        if (profile == null) return const SizedBox();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(workerProfileProvider);
            ref.invalidate(workerEarningsProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status Switch Card
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isOnline
                          ? [const Color(0xFF10B981), const Color(0xFF059669)]
                          : [const Color(0xFF64748B), const Color(0xFF475569)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (isOnline ? const Color(0xFF10B981) : const Color(0xFF64748B)).withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isOnline ? 'ONLINE & RECEIVING JOBS' : 'OFFLINE',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isOnline ? 'Visible to nearby customers' : 'Toggle on to start accepting tasks',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: isOnline,
                        onChanged: _toggleOnlineStatus,
                        activeThumbColor: const Color(0xFF10B981),
                        activeTrackColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Quick Stats Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF4F46E5), size: 20),
                            ),
                            const SizedBox(height: 12),
                            const Text("Today's Earnings", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            earningsAsync.when(
                              data: (earnings) => Text(
                                'Rs. ${earnings.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                              ),
                              loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                              error: (_, __) => const Text('Rs. 0'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.verified_rounded, color: Color(0xFF10B981), size: 20),
                            ),
                            const SizedBox(height: 12),
                            const Text("Completed Jobs", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(
                              '${profile.completedJobs}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Jobs Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Available Nearby Jobs",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Live Feed",
                        style: TextStyle(fontSize: 12, color: Color(0xFF4F46E5), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Incoming Job Requests List
                IncomingJobsList(serviceId: profile.serviceId),
              ],
            ),
          ),
        );
      },
    );
  }
}
