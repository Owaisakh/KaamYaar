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
    await _supabase.auth.signInWithOtp(phone: phone);
  }

  @override
  Future<void> verifyOTP(String phone, String otp) async {
    await _supabase.auth.verifyOTP(
      type: OtpType.sms,
      phone: phone,
      token: otp,
    );
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
AuthRepository authRepository(AuthRepositoryRef ref) {
  return SupabaseAuthRepository(Supabase.instance.client);
}
