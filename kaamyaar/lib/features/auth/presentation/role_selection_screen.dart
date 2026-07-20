import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/user_model.dart';
import '../../../../core/supabase/auth_provider.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  void _selectRole(BuildContext context, WidgetRef ref, UserRole role) async {
    final authState = ref.read(authNotifierProvider);
    final user = authState.value;
    if (user != null) {
      final updatedUser = user.copyWith(role: role);
      await ref.read(authNotifierProvider.notifier).updateUserProfile(updatedUser);
      // After updating, app router will redirect based on the new state
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Role')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _selectRole(context, ref, UserRole.customer),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
              ),
              child: const Text('I am a Customer', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _selectRole(context, ref, UserRole.worker),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
              ),
              child: const Text('I am a Worker', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
