import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_model.dart';

abstract class AuthRepository {
  /// Send OTP to the given phone number
  Future<void> sendOTP(String phone);

  /// Sign in with Google
  Future<void> signInWithGoogle();

  /// Verify OTP
  Future<void> verifyOTP(String phone, String otp);

  /// Sign out the current user
  Future<void> signOut();

  /// Get current user ID
  String? get currentUserId;

  /// Fetch user profile from database
  Future<UserModel?> getUserProfile(String userId);

  /// Create or update user profile
  Future<void> updateUserProfile(UserModel user);
}
