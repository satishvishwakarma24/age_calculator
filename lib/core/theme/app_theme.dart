import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand / Accent ─────────────────────────
  static const Color primaryPurple = Color(0xFF7C5CFF);
  static const Color accentTeal = Color(0xFF5CE1E6);
  static const Color background = Color(0xFFF4F6FF);
  static const Color cardWhite = Colors.white;

  // ── Text ────────────────────────────────────
  static const Color textPrimary = Color(0xFF050A18);
  static const Color textSub = Color(0xFF3D5070);
  static const Color textTeal = Color(0xFF5CE1E6);

  // ── Legacy / Ads Support ─────────────────────
  static const Color starBlue = primaryPurple;
  static const Color textOnCta = Colors.white;
  static Color bgMid = primaryPurple.withValues(alpha: 0.1);

  // ── Planet palette ──────────────────────────
  static const Color mercury = Color(0xFFBDBDBD);
  static const Color venus = Color(0xFFE5C185);
  static const Color earth = Color(0xFF4A90E2);
  static const Color mars = Color(0xFFD8543E);
  static const Color jupiter = Color(0xFFD5A67D);
  static const Color saturn = Color(0xFFEAD68C);
  static const Color uranus = Color(0xFF8DE2E6);
  static const Color neptune = Color(0xFF5C6BC0);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPurple,
          primary: AppColors.primaryPurple,
          secondary: AppColors.accentTeal,
          surface: AppColors.cardWhite,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size.fromHeight(56),
            side: BorderSide(color: Colors.grey.shade200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cardWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryPurple),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.cardWhite,
          indicatorColor: AppColors.primaryPurple.withValues(alpha: 0.1),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: AppColors.textSub);
          }),
        ),
      );

  static ThemeData get dark => light.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1030),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPurple,
          brightness: Brightness.dark,
          surface: const Color(0xFF17205A),
        ),
      );
}
