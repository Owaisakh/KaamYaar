import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Customer App (Dark Navy & Teal Accent)
  static const Color customerPrimary = Color(0xFF0F172A); // Dark Navy
  static const Color customerAccent = Color(0xFF14B8A6);  // Teal Accent
  static const Color customerBgLight = Color(0xFFF8FAFC);
  static const Color customerSurface = Colors.white;

  // Brand Colors - Worker App (Teal Primary & Dark Navy Secondary)
  static const Color workerPrimary = Color(0xFF14B8A6);   // Teal
  static const Color workerSecondary = Color(0xFF0F172A); // Dark Navy
  static const Color workerDarkTeal = Color(0xFF0D9488);  // Deep Teal
  static const Color workerBgLight = Color(0xFFF8FAFC);
  static const Color workerSurface = Colors.white;

  // Legacy compatibility mapping
  static const Color primaryPurple = Color(0xFF0F172A);
  static const Color primaryBlue = Color(0xFF14B8A6);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Status & Feedback Palette
  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color error = Color(0xFFEF4444);   // Crimson Red
  static const Color warning = Color(0xFFF59E0B); // Amber Yellow
  static const Color info = Color(0xFF3B82F6);    // Electric Blue

  // Card Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFF1F5F9);
}
