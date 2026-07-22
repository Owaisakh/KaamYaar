import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../supabase/auth_provider.dart';
import '../../features/auth/domain/user_model.dart';

// Presentation imports
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/auth/presentation/role_selection_screen.dart';
import '../../features/customer/presentation/onboarding/onboarding_screen.dart';
import '../../features/customer/presentation/location/location_setup_screen.dart';
import '../../features/customer/presentation/customer_main_screen.dart';
import '../../features/customer/presentation/home/service_search_screen.dart';
import '../../features/customer/presentation/home/category_details_screen.dart';
import '../../features/bookings/presentation/booking_flow_screen.dart';
import '../../features/bookings/domain/service_model.dart';
import '../../features/customer/presentation/bookings/matching_radar_screen.dart';
import '../../features/customer/presentation/bookings/worker_assigned_screen.dart';
import '../../features/customer/presentation/bookings/live_tracking_screen.dart';
import '../../features/customer/presentation/chat/in_app_chat_screen.dart';
import '../../features/customer/presentation/bookings/payment_screen.dart';
import '../../features/customer/presentation/bookings/review_screen.dart';
import '../../features/customer/presentation/notifications/notifications_screen.dart';
import '../../features/customer/presentation/help/help_center_screen.dart';
import '../../features/customer/presentation/settings/settings_screen.dart';
import '../../features/bookings/domain/booking_model.dart';

// Worker presentation imports
import '../../features/worker/presentation/onboarding/worker_registration_screen.dart';
import '../../features/worker/presentation/skills/worker_skill_selection_screen.dart';
import '../../features/worker/presentation/verification/document_verification_screen.dart';
import '../../features/worker/presentation/dashboard/worker_dashboard_screen.dart';
import '../../features/worker/presentation/jobs/active_job_screen.dart';
import '../../features/worker/presentation/wallet/worker_wallet_screen.dart';

// Admin presentation imports
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/verifications/admin_verifications_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isLogin = state.matchedLocation == '/login';
      final isOtp = state.matchedLocation == '/otp';
      
      return authState.when(
        data: (user) {
          if (user == null) {
            if (isSplash || isOnboarding || isLogin || isOtp) return null;
            return '/login';
          }
          
          if (user.role == null) {
            if (state.matchedLocation == '/role-selection') return null;
            return '/role-selection';
          }

          if (isSplash || isOnboarding || isLogin || isOtp || state.matchedLocation == '/role-selection') {
            return '/';
          }

          return null;
        },
        loading: () => (isSplash || isLogin || isOtp) ? null : '/splash',
        error: (_, __) => (isLogin || isOtp) ? null : '/login',
      );
    },
    routes: [
      // Core & Auth
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpVerificationScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          final user = ref.read(authProvider).value;
          if (user?.role == UserRole.admin) {
            return const AdminDashboardScreen();
          } else if (user?.role == UserRole.worker) {
            return const WorkerDashboardScreen();
          }
          return const CustomerMainScreen();
        },
      ),

      // Customer App Routes
      GoRoute(
        path: '/location-setup',
        builder: (context, state) => const LocationSetupScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const ServiceSearchScreen(),
      ),
      GoRoute(
        path: '/category/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'plumbing';
          return CategoryDetailsScreen(categoryId: id);
        },
      ),
      GoRoute(
        path: '/book-service',
        builder: (context, state) {
          final service = state.extra as ServiceModel;
          return BookingFlowScreen(service: service);
        },
      ),
      GoRoute(
        path: '/matching',
        builder: (context, state) => const MatchingRadarScreen(),
      ),
      GoRoute(
        path: '/worker-assigned',
        builder: (context, state) => const WorkerAssignedScreen(),
      ),
      GoRoute(
        path: '/live-tracking',
        builder: (context, state) {
          final bookingId = state.extra as String? ?? '';
          return LiveTrackingScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final bookingId = state.extra as String? ?? '';
          return InAppChatScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return PaymentScreen(booking: booking);
        },
      ),
      GoRoute(
        path: '/review',
        builder: (context, state) {
          final booking = state.extra as BookingModel;
          return ReviewScreen(booking: booking);
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Worker App Routes
      GoRoute(
        path: '/worker/register',
        builder: (context, state) => const WorkerRegistrationScreen(),
      ),
      GoRoute(
        path: '/worker/skills',
        builder: (context, state) => const WorkerSkillSelectionScreen(),
      ),
      GoRoute(
        path: '/worker/verification',
        builder: (context, state) => const DocumentVerificationScreen(),
      ),
      GoRoute(
        path: '/worker/dashboard',
        builder: (context, state) => const WorkerDashboardScreen(),
      ),
      GoRoute(
        path: '/worker/active-job',
        builder: (context, state) {
          final job = state.extra as BookingModel;
          return ActiveJobScreen(job: job);
        },
      ),
      GoRoute(
        path: '/worker/wallet',
        builder: (context, state) => const WorkerWalletScreen(),
      ),

      // Admin Routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/verifications',
        builder: (context, state) => const AdminVerificationsScreen(),
      ),
    ],
  );
}
