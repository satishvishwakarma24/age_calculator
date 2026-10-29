import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16.dp,
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

  // ── Dark theme colours ──────────────────────
  static const Color _darkBg = Color(0xFF050A18);
  static const Color _darkCard = Color(0xFF0F1A3A);
  static const Color _darkSurface = Color(0xFF17205A);
  static const Color _darkInputFill = Color(0xFF111C3A);
  static const Color _darkNavBar = Color(0xFF0A1030);
  static const Color _darkBorder = Color(0xFF1E2D55);

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _darkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPurple,
          brightness: Brightness.dark,
          primary: AppColors.primaryPurple,
          secondary: AppColors.accentTeal,
          surface: _darkSurface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.dp,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          color: _darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: _darkBorder),
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
            foregroundColor: Colors.white70,
            minimumSize: const Size.fromHeight(56),
            side: const BorderSide(color: _darkBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _darkInputFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryPurple),
          ),
          labelStyle: const TextStyle(color: Colors.white60),
          hintStyle: const TextStyle(color: Colors.white38),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: _darkNavBar,
          indicatorColor: AppColors.primaryPurple.withValues(alpha: 0.25),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  color: AppColors.primaryPurple, fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: Colors.white54);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.primaryPurple);
            }
            return const IconThemeData(color: Colors.white54);
          }),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        dividerColor: _darkBorder,
      );
}
