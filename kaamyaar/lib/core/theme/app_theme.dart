import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Customer App Theme (Dark Navy Primary, Teal Accent)
  static ThemeData get customerTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.customerPrimary,
        primary: AppColors.customerPrimary,
        secondary: AppColors.customerAccent,
        surface: AppColors.customerSurface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.customerBgLight,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.customerPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.customerPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
    );
  }

  // Worker App Theme (Teal Primary, Dark Navy Secondary)
  static ThemeData get workerTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.workerPrimary,
        primary: AppColors.workerPrimary,
        secondary: AppColors.workerSecondary,
        surface: AppColors.workerSurface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.workerBgLight,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.workerSecondary),
        titleTextStyle: TextStyle(
          color: AppColors.workerSecondary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
    );
  }

  // Legacy Theme Getters for Backward Compatibility
  static ThemeData get lightTheme => customerTheme;
  static ThemeData get darkTheme => workerTheme;
}
