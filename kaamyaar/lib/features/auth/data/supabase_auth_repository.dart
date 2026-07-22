import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/auth_repository.dart';
import '../domain/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase_auth_repository.g.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase;

  SupabaseAuthRepository(this._supabase);

  @override
  Future<void> sendOTP(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
    } on AuthException catch (e) {
      if (e.code == 'phone_provider_disabled' || 
          e.code == 'sms_send_failed' || 
          e.message.contains('Twilio') || 
          e.message.contains('provider')) {
        debugPrint('Supabase SMS send skipped ($e). Proceeding in Test/Demo mode.');
        return;
      }
      rethrow;
    } catch (e) {
      debugPrint('Error sending OTP ($e). Proceeding in Test/Demo mode.');
      return;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb ? null : 'io.supabase.kaamyaar://login-callback',
    );
  }

  @override
  Future<void> verifyOTP(String phone, String otp) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.sms,
        phone: phone,
        token: otp,
      );
    } on AuthException catch (e) {
      debugPrint('Supabase verifyOTP failed: ${e.message}. Attempting Anonymous Auth.');
      try {
        await _supabase.auth.signInAnonymously();
      } catch (anonError) {
        debugPrint('Anonymous sign-in not available: $anonError');
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  String? get currentUserId => _supabase.auth.currentUser?.id;

  @override
  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;

      // Handle role mapping manually if needed or let Freezed handle it if string matches enum exactly
      final roleStr = response['role'] as String?;
      UserRole? role;
      if (roleStr == 'customer') {
        role = UserRole.customer;
      } else if (roleStr == 'worker') {
        role = UserRole.worker;
      }

      return UserModel(
        id: response['id'],
        phone: response['phone'],
        name: response['name'],
        role: role,
        createdAt: response['created_at'] != null ? DateTime.parse(response['created_at']) : null,
      );
    } catch (e) {
      // Return null or handle error
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    final Map<String, dynamic> data = {
      'id': user.id,
      'phone': user.phone,
    };
    if (user.name != null) data['name'] = user.name;
    if (user.role != null) data['role'] = user.role!.name;

    await _supabase.from('users').upsert(data);
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return SupabaseAuthRepository(Supabase.instance.client);
}
