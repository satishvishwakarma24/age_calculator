import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Background ─────────────────────────────
  static const Color bgDeep = Color(0xFF050A18);
  static const Color bgMid = Color(0xFF0D1F3C);

  // ── Brand / Accent ─────────────────────────
  static const Color starBlue = Color(0xFF4FC3F7); // primary CTA & glow
  static const Color tealAccent = Color(0xFF26C6DA); // compare screen
  static const Color lavender = Color(0xFFCE93D8); // members & months
  static const Color amber = Color(0xFFFFD54F); // birthdays & hours
  static const Color orange = Color(0xFFFF7043); // Mars

  // ── Surface / Glass ─────────────────────────
  static Color glassBlue = starBlue.withOpacity(0.04);
  static Color glassBorder = starBlue.withOpacity(0.15);
  static Color glassBorderWeak = starBlue.withOpacity(0.10);

  // ── Text ────────────────────────────────────
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSub = Color(0xFF8899BB);
  static const Color textMuted = Color(0xFF3D5070);
  static const Color textOnCta = Color(0xFF050A18); // dark text on CTA btn

  // ── Planet palette ──────────────────────────
  static const Color mercury = Color(0xFFBDBDBD);
  static const Color venus = Color(0xFFFFCC02);
  static const Color mars = Color(0xFFFF7043);
  static const Color jupiter = Color(0xFFFFAB40);
  static const Color saturn = Color(0xFFF3E5AB);
  static const Color uranus = Color(0xFF80DEEA);
  static const Color neptune = Color(0xFF5C6BC0);
  static const Color sun = Color(0xFFFFD700);
}

// ─────────────────────────────────────────────
//  Gradients
// ─────────────────────────────────────────────

class AppGradients {
  AppGradients._();

  static const LinearGradient ctaBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4FC3F7), Color(0xFF1A6EAF)],
  );

  static const LinearGradient ctaTeal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF26C6DA), Color(0xFF0097A7)],
  );

  static const LinearGradient ctaLavender = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFCE93D8), Color(0xFF4FC3F7)],
  );

  static const RadialGradient bgRadial = RadialGradient(
    center: Alignment(-0.4, -0.6),
    radius: 1.2,
    colors: [Color(0xFF0D1F3C), Color(0xFF050A18)],
  );

  static const RadialGradient bgRadialLight = RadialGradient(
    center: Alignment(-0.4, -0.6),
    radius: 1.2,
    colors: [Color(0xFFDCE8F8), Color(0xFFEEF3FB)],
  );

  static const RadialGradient sunGlow = RadialGradient(
    colors: [Color(0xFFFFFACC), Color(0xFFFFD700), Color(0xFFFF8C00)],
  );

  static const RadialGradient orb = RadialGradient(
    colors: [Color(0xFF4FC3F7), Color(0xFF1A5276)],
  );
}

// ─────────────────────────────────────────────
//  Text Styles
// ─────────────────────────────────────────────

class AppText {
  AppText._();

  static const String fontFamily = 'SF Pro Display'; // falls back to system

  static const TextStyle screenLabel = TextStyle(
    fontSize: 8,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 10,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
  );

  static const TextStyle resultBig = TextStyle(
    fontSize: 64,
    color: AppColors.starBlue,
    fontWeight: FontWeight.w800,
    height: 1,
  );

  static const TextStyle resultUnit = TextStyle(
    fontSize: 14,
    color: AppColors.textSub,
    letterSpacing: 0.5,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 15,
    color: AppColors.starBlue,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 9,
    color: AppColors.textMuted,
    letterSpacing: 0.8,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle dateValue = TextStyle(
    fontSize: 15,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 10,
    color: AppColors.textMuted,
    letterSpacing: 1.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle ctaButton = TextStyle(
    fontSize: 12,
    color: AppColors.textOnCta,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static const TextStyle planetName = TextStyle(
    fontSize: 10,
    color: AppColors.textSub,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle planetAge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const TextStyle diffNumber = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1,
  );

  static const TextStyle memberName = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle memberDetail = TextStyle(
    fontSize: 11,
    color: AppColors.textMuted,
  );

  static const TextStyle tagText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}

// ─────────────────────────────────────────────
//  Dimensions
// ─────────────────────────────────────────────

class AppDimens {
  AppDimens._();

  static const double radiusCard = 16.0;
  static const double radiusField = 10.0;
  static const double radiusButton = 12.0;
  static const double radiusTag = 6.0;
  static const double radiusOrb = 999.0;

  static const double paddingPage = 20.0;
  static const double paddingCard = 16.0;
  static const double gapSm = 8.0;
  static const double gapMd = 12.0;
  static const double gapLg = 16.0;
  static const double gapXl = 24.0;

  static const double navBarHeight = 70.0;
  static const double fabSize = 56.0;
}

// ─────────────────────────────────────────────
//  Shadows & Glows
// ─────────────────────────────────────────────

class AppShadows {
  AppShadows._();

  static List<BoxShadow> glowBlue({double spread = 20, double opacity = 0.5}) =>
      [
        BoxShadow(
          color: AppColors.starBlue.withOpacity(opacity),
          blurRadius: spread,
          spreadRadius: spread * 0.15,
        ),
      ];

  static List<BoxShadow> glowLavender({double spread = 20}) => [
        BoxShadow(
          color: AppColors.lavender.withOpacity(0.4),
          blurRadius: spread,
          spreadRadius: spread * 0.1,
        ),
      ];

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}

// ─────────────────────────────────────────────
//  Theme extension — brightness-aware cosmic palette
// ─────────────────────────────────────────────

@immutable
class CosmicTheme extends ThemeExtension<CosmicTheme> {
  final Color scaffoldBackground;
  final Color textPrimary;
  final Color textSub;
  final Color textMuted;
  final Color glassFill;
  final Color glassBorder;
  final Color navBarBackground;
  final Color starParticle;
  final RadialGradient backgroundGradient;

  const CosmicTheme({
    required this.scaffoldBackground,
    required this.textPrimary,
    required this.textSub,
    required this.textMuted,
    required this.glassFill,
    required this.glassBorder,
    required this.navBarBackground,
    required this.starParticle,
    required this.backgroundGradient,
  });

  static const CosmicTheme dark = CosmicTheme(
    scaffoldBackground: AppColors.bgDeep,
    textPrimary: AppColors.textPrimary,
    textSub: AppColors.textSub,
    textMuted: AppColors.textMuted,
    glassFill: Color(0x0A4FC3F7),
    glassBorder: Color(0x264FC3F7),
    navBarBackground: Color(0xF2050A18),
    starParticle: Colors.white,
    backgroundGradient: AppGradients.bgRadial,
  );

  static const CosmicTheme light = CosmicTheme(
    scaffoldBackground: Color(0xFFEEF3FB),
    textPrimary: Color(0xFF0A1628),
    textSub: Color(0xFF5A6B85),
    textMuted: Color(0xFF8A9BB5),
    glassFill: Color(0x144FC3F7),
    glassBorder: Color(0x334FC3F7),
    navBarBackground: Color(0xF2EEF3FB),
    starParticle: Color(0xFF4FC3F7),
    backgroundGradient: AppGradients.bgRadialLight,
  );

  static CosmicTheme of(BuildContext context) {
    return Theme.of(context).extension<CosmicTheme>() ?? CosmicTheme.dark;
  }

  @override
  CosmicTheme copyWith({
    Color? scaffoldBackground,
    Color? textPrimary,
    Color? textSub,
    Color? textMuted,
    Color? glassFill,
    Color? glassBorder,
    Color? navBarBackground,
    Color? starParticle,
    RadialGradient? backgroundGradient,
  }) {
    return CosmicTheme(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      textPrimary: textPrimary ?? this.textPrimary,
      textSub: textSub ?? this.textSub,
      textMuted: textMuted ?? this.textMuted,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      navBarBackground: navBarBackground ?? this.navBarBackground,
      starParticle: starParticle ?? this.starParticle,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  CosmicTheme lerp(ThemeExtension<CosmicTheme>? other, double t) {
    if (other is! CosmicTheme) return this;
    return CosmicTheme(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSub: Color.lerp(textSub, other.textSub, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      navBarBackground:
          Color.lerp(navBarBackground, other.navBarBackground, t)!,
      starParticle: Color.lerp(starParticle, other.starParticle, t)!,
      backgroundGradient:
          t < 0.5 ? backgroundGradient : other.backgroundGradient,
    );
  }
}

// ─────────────────────────────────────────────
//  ThemeData
// ─────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, CosmicTheme.dark);

  static ThemeData get light => _build(Brightness.light, CosmicTheme.light);

  static ThemeData _build(Brightness brightness, CosmicTheme cosmic) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: cosmic.scaffoldBackground,
      fontFamily: AppText.fontFamily,
      extensions: [cosmic],
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: AppColors.starBlue,
              secondary: AppColors.lavender,
              tertiary: AppColors.tealAccent,
              surface: AppColors.bgMid,
            )
          : const ColorScheme.light(
              primary: AppColors.starBlue,
              secondary: AppColors.lavender,
              tertiary: AppColors.tealAccent,
              surface: Color(0xFFDCE8F8),
            ),
      splashColor: AppColors.starBlue.withValues(alpha: 0.08),
      highlightColor: Colors.transparent,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
