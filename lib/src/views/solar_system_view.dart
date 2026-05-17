import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/solar/solar_system_canvas.dart';
import '../widgets/solar/planet_age_card.dart';

// ─────────────────────────────────────────────
//  SolarSystemView
//  Shows the animated solar system + a scrollable
//  list of planetary age equivalents.
// ─────────────────────────────────────────────

class SolarSystemView extends StatelessWidget {
  const SolarSystemView({super.key});

  // Placeholder data — Phase 2 will compute from DOB
  static const _planets = [
    PlanetAgeData(
      name: 'Mercury',
      symbol: '☿',
      description: '1 Earth yr = 4.15 Mercury yrs',
      formattedAge: '137.4',
      color: AppColors.mercury,
    ),
    PlanetAgeData(
      name: 'Venus',
      symbol: '♀',
      description: '1 Earth yr = 1.62 Venus yrs',
      formattedAge: '53.7',
      color: AppColors.venus,
    ),
    PlanetAgeData(
      name: 'Mars',
      symbol: '♂',
      description: '1 Earth yr = 0.53 Mars yrs',
      formattedAge: '17.6',
      color: AppColors.mars,
    ),
    PlanetAgeData(
      name: 'Jupiter',
      symbol: '♃',
      description: '1 Earth yr = 0.084 Jupiter yrs',
      formattedAge: '2.8',
      color: AppColors.jupiter,
    ),
    PlanetAgeData(
      name: 'Saturn',
      symbol: '♄',
      description: '1 Earth yr = 0.034 Saturn yrs',
      formattedAge: '1.1',
      color: AppColors.saturn,
    ),
    PlanetAgeData(
      name: 'Uranus',
      symbol: '⛢',
      description: '1 Earth yr = 0.012 Uranus yrs',
      formattedAge: '0.4',
      color: AppColors.uranus,
    ),
    PlanetAgeData(
      name: 'Neptune',
      symbol: '♆',
      description: '1 Earth yr = 0.006 Neptune yrs',
      formattedAge: '0.2',
      color: AppColors.neptune,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Sticky solar canvas + header ─────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.paddingPage,
                  AppDimens.paddingPage,
                  AppDimens.paddingPage,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    ScreenHeader(
                      orb: CosmicOrb(
                        size: 44,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF26C6DA), Color(0xFF4FC3F7)],
                        ),
                        shadows: [
                          BoxShadow(
                            color: AppColors.tealAccent.withOpacity(0.4),
                            blurRadius: 14,
                          ),
                        ],
                        child: const Icon(
                          Icons.public_rounded,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Planets',
                      subtitle: 'Your age across the solar system',
                    ),
                    const SizedBox(height: AppDimens.gapLg),

                    // Animated solar system canvas
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusCard),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.starBlue.withOpacity(0.03),
                          border: Border.all(
                              color: AppColors.glassBorderWeak),
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusCard),
                        ),
                        child: const SolarSystemCanvas(),
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapLg),

                    Text(
                      'PLANETARY AGE',
                      style: AppText.sectionTitle,
                    ),
                    const SizedBox(height: AppDimens.gapSm),
                  ],
                ),
              ),
            ),

            // ── Planet cards list ─────────────────────────
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.paddingPage,
                0,
                AppDimens.paddingPage,
                AppDimens.paddingPage + AppDimens.navBarHeight,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => PlanetAgeCard(data: _planets[i]),
                  childCount: _planets.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}