import 'package:flutter/material.dart';
import 'package:age_calculator/config/routes/routes_name.dart';
import 'package:age_calculator/l10n/app_localizations.dart';
import 'package:age_calculator/core/theme/app_theme.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  SplashView
//  First screen — centered logo, title, tagline
//  and "Begin Exploration" CTA.
//
//  Navigation:
//    CTA → RoutesName.homeScreen
// ─────────────────────────────────────────────

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _slideAnim = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );

    _ctrl.forward();
  }

  void _onBegin() {
    Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CosmicBackground(
        starCount: 100,
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, child) => Opacity(
                opacity: _fadeAnim.value,
                child: Transform.translate(
                  offset: Offset(0, _slideAnim.value),
                  child: child,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: _SplashLogo(),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      l10n.appTitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 34,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 6,
                        shadows: [
                          Shadow(
                            color: AppColors.starBlue.withOpacity(0.7),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.splashTagline,
                      style: AppText.screenLabel.copyWith(
                        letterSpacing: 3,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.splashDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSub,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 48),
                    CosmicButton(
                      label: l10n.beginExploration,
                      onPressed: _onBegin,
                      gradient: AppGradients.ctaBlue,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.privacyNote,
                      style: AppText.statLabel.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatefulWidget {
  @override
  State<_SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<_SplashLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) {
        final glow = 20.0 + _pulse.value * 16;
        return Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF1A6EAF), Color(0xFF0A3860)],
            ),
            border: Border.all(
              color: AppColors.starBlue.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.starBlue.withOpacity(0.45),
                blurRadius: glow,
                spreadRadius: glow * 0.2,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            '✦',
            style: TextStyle(
              fontSize: 38,
              color: AppColors.starBlue,
            ),
          ),
        );
      },
    );
  }
}
