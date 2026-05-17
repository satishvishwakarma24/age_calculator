import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../utils/age_calculation.dart';
import '../utils/age_calculator_provider.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/solar/solar_system_canvas.dart';
import '../widgets/solar/planet_age_card.dart';

// ─────────────────────────────────────────────
//  SolarSystemView
//  Shows the animated solar system + a scrollable
//  list of planetary age equivalents (synced with
//  the same DOB / calculation as CalculatorView).
// ─────────────────────────────────────────────

class SolarSystemView extends StatelessWidget {
  const SolarSystemView({super.key});

  static const _planetColors = {
    'Mercury': AppColors.mercury,
    'Venus': AppColors.venus,
    'Mars': AppColors.mars,
    'Jupiter': AppColors.jupiter,
    'Saturn': AppColors.saturn,
    'Uranus': AppColors.uranus,
    'Neptune': AppColors.neptune,
  };

  List<PlanetAgeData> _buildPlanetCards(List<PlanetAgeInfo> infos) {
    return infos
        .map(
          (p) => PlanetAgeData(
            name: p.name,
            symbol: p.symbol,
            description: p.description,
            formattedAge: formatPlanetAge(p.ageOnPlanet),
            color: _planetColors[p.name] ?? AppColors.starBlue,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final calc = context.watch<AgeCalculatorProvider>();
    final planets = calc.hasCalculated && calc.result != null
        ? _buildPlanetCards(calc.planetAges)
        : <PlanetAgeData>[];

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
                    const ScreenHeader(
                      orb: CosmicOrb(
                        size: 44,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF26C6DA), Color(0xFF4FC3F7)],
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x6626C6DA),
                            blurRadius: 14,
                          ),
                        ],
                        child: Icon(
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
                    if (!calc.hasCalculated || calc.result == null) ...[
                      const SizedBox(height: AppDimens.gapSm),
                      Text(
                        'Set your date of birth on the Calc tab, then tap Calculate Age.',
                        style: AppText.statLabel,
                      ),
                    ],
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
              sliver: planets.isEmpty
                  ? const SliverToBoxAdapter(child: SizedBox.shrink())
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => PlanetAgeCard(data: planets[i]),
                        childCount: planets.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
