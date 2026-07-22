import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_model.dart';
import '../../../../core/supabase/auth_provider.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  UserRole? _selectedRole = UserRole.customer;
  bool _isSubmitting = false;

  void _confirmRole() async {
    if (_selectedRole == null || _isSubmitting) return;

    setState(() => _isSubmitting = true);
    try {
      final authState = ref.read(authProvider);
      final user = authState.value;
      if (user != null) {
        final updatedUser = user.copyWith(role: _selectedRole);
        await ref.read(authProvider.notifier).updateUserProfile(updatedUser);
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // Header Badge & Title
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Step 2 of 2 • Account Setup',
                    style: TextStyle(
                      color: Color(0xFF4F46E5),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'How will you use\nKaamYaar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose your role to customize your experience.\nYou can switch anytime later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 36),

              // Selection Cards
              Expanded(
                child: Column(
                  children: [
                    _buildRoleCard(
                      role: UserRole.customer,
                      icon: Icons.person_search_rounded,
                      title: 'Need a Service',
                      subtitle: 'Book trusted plumbers, electricians, carpenters & home experts instantly.',
                      accentGradient: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    ),
                    const SizedBox(height: 20),
                    _buildRoleCard(
                      role: UserRole.worker,
                      icon: Icons.handyman_rounded,
                      title: 'Offer a Service',
                      subtitle: 'Find daily jobs nearby, earn competitive income & grow your business.',
                      accentGradient: const [Color(0xFF0EA5E9), Color(0xFF0284C7)],
                    ),
                  ],
                ),
              ),

              // Continue Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _confirmRole,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 22),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> accentGradient,
  }) {
    final isSelected = _selectedRole == role;

    return InkWell(
      onTap: () => setState(() => _selectedRole = role),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accentGradient.first : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentGradient.first.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSelected ? accentGradient : [Colors.grey.shade400, Colors.grey.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: accentGradient.first.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF334155),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? accentGradient.first : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? accentGradient.first : const Color(0xFF94A3B8),
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? const Color(0xFF475569) : const Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
