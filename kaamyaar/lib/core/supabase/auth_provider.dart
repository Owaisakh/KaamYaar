import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/data/supabase_auth_repository.dart';
import '../../features/auth/domain/user_model.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<UserModel?> build() {
    // Start listening to auth state changes immediately
    _listenToAuthState();
    return const AsyncValue.loading();
  }

  void _listenToAuthState() {
    supabase.Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null) {
        // Fetch user profile from DB
        final repo = ref.read(authRepositoryProvider);
        try {
          final profile = await repo.getUserProfile(session.user.id);
          state = AsyncValue.data(profile);
        } catch (e, st) {
          state = AsyncValue.error(e, st);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  Future<void> sendOTP(String phone) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.sendOTP(phone);
      // Wait for verifyOTP to change state
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> verifyOTP(String phone, String otp) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.verifyOTP(phone, otp);
      // auth state listener will update the user profile
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signOut();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.updateUserProfile(user);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
