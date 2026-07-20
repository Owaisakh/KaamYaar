import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../supabase/auth_provider.dart';
import '../../features/auth/domain/user_model.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/auth/presentation/role_selection_screen.dart';
import '../../features/customer/presentation/customer_main_screen.dart';
import '../../features/customer/presentation/home/service_search_screen.dart';
import '../../features/bookings/presentation/booking_flow_screen.dart';
import '../../features/bookings/domain/service_model.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isLogin = state.matchedLocation == '/login';
      final isOtp = state.matchedLocation == '/otp';
      
      return authState.when(
        data: (user) {
          if (user == null) {
            if (isLogin || isOtp || isSplash) return null;
            return '/login';
          }
          
          if (user.role == null) {
            if (state.matchedLocation == '/role-selection') return null;
            return '/role-selection';
          }

          if (isLogin || isOtp || isSplash || state.matchedLocation == '/role-selection') {
            return '/';
          }

          return null;
        },
        loading: () => isSplash ? null : '/splash',
        error: (_, __) => '/login',
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
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
          final user = ref.read(authNotifierProvider).value;
          if (user?.role == UserRole.worker) {
            return const Scaffold(
              body: Center(
                child: Text('Worker Dashboard Coming Soon'),
              ),
            );
          }
          return const CustomerMainScreen();
        },
      ),
      GoRoute(
        path: '/service-search',
        builder: (context, state) => const ServiceSearchScreen(),
      ),
      GoRoute(
        path: '/book-service',
        builder: (context, state) {
          final service = state.extra as ServiceModel;
          return BookingFlowScreen(service: service);
        },
      ),
    ],
  );
}
