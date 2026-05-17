import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/calculator/age_result_card.dart';
import '../widgets/calculator/birthday_countdown_card.dart';

// ─────────────────────────────────────────────
//  CalculatorView
//  Main age calculator screen.
//
//  State will be wired via a CalculatorController
//  in Phase 2. All values here are display-only
//  placeholders that match the design preview.
// ─────────────────────────────────────────────

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  // Placeholder date — will be driven by controller in Phase 2
  final String _dobDisplay = '15 Mar 1992';
  bool _hasResult = true; // show result section

  void _pickDate() {
    // Phase 2: show date picker via controller
    // For now, toggle a visual cue
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                      value: _dobDisplay,
                      accentColor: AppColors.starBlue,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: AppDimens.gapMd),
                    CosmicButton(
                      label: '✦  CALCULATE AGE',
                      onPressed: () => setState(() => _hasResult = true),
                      gradient: AppGradients.ctaBlue,
                    ),
                  ],
                ),
              ),

              // ── Results section ──────────────────────────
              if (_hasResult) ...[
                const SizedBox(height: AppDimens.gapMd),
                const AgeResultCard(
                  years: 33,
                  months: 1,
                  days: 15,
                  totalDays: 12098,
                  totalMonths: 397,
                  totalHours: 290352,
                ),
                const SizedBox(height: AppDimens.gapMd),
                const BirthdayCountdownCard(
                  nextBirthdayDate: '15 Mar 2026',
                  daysUntil: 319,
                  zodiacSign: 'Pisces ♓',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}