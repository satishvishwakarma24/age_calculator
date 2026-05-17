import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../utils/age_calculator_provider.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/calculator/age_result_card.dart';
import '../widgets/calculator/birthday_countdown_card.dart';

// ─────────────────────────────────────────────
//  CalculatorView
//  Main age calculator screen — DOB picker,
//  calculate CTA, and live results.
// ─────────────────────────────────────────────

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = context.watch<AgeCalculatorProvider>();
    final result = calc.result;

    return CosmicBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.paddingPage,
            AppDimens.paddingPage,
            AppDimens.paddingPage,
            AppDimens.paddingPage + AppDimens.navBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────
              const ScreenHeader(
                orb: CosmicOrb(
                  size: 44,
                  child: Text(
                    '✦',
                    style: TextStyle(fontSize: 20, color: AppColors.starBlue),
                  ),
                ),
                title: 'Age Calc',
                subtitle: 'Cosmic Age Explorer',
              ),
              const SizedBox(height: AppDimens.gapXl),

              // ── Date of Birth input ──────────────────────
              GlassCard(
                child: Column(
                  children: [
                    CosmicDateField(
                      label: 'Date of Birth',
                      value: calc.formattedDob,
                      accentColor: AppColors.starBlue,
                      onTap: calc.isCalculating
                          ? () {}
                          : () => calc.pickDate(context),
                    ),
                    const SizedBox(height: AppDimens.gapMd),
                    CosmicButton(
                      label: '✦  CALCULATE AGE',
                      loadingLabel: '✦  CALCULATING…',
                      isLoading: calc.isCalculating,
                      onPressed: () => calc.calculate(),
                      gradient: AppGradients.ctaBlue,
                    ),
                  ],
                ),
              ),

              // ── Results section ──────────────────────────
              if (calc.hasCalculated && result != null) ...[
                const SizedBox(height: AppDimens.gapMd),
                AgeResultCard(
                  years: result.years,
                  months: result.months,
                  days: result.days,
                  totalDays: result.totalDays,
                  totalMonths: result.totalMonths,
                  totalHours: result.totalHours,
                ),
                const SizedBox(height: AppDimens.gapMd),
                BirthdayCountdownCard(
                  nextBirthdayDate: calc.formatNextBirthday(),
                  daysUntil: result.daysUntilBirthday,
                  zodiacSign: result.zodiacSign,
                ),
              ] else if (calc.hasCalculated) ...[
                const SizedBox(height: AppDimens.gapMd),
                GlassCard(
                  child: Text(
                    'Please choose a date of birth that is not in the future.',
                    style: AppText.statLabel.copyWith(color: AppColors.amber),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
