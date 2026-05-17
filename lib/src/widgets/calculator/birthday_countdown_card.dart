import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  BirthdayCountdownCard
//  Shows next birthday date and days-remaining.
//  Displayed below the main AgeResultCard on
//  the Calculator screen.
// ─────────────────────────────────────────────

class BirthdayCountdownCard extends StatelessWidget {
  final String nextBirthdayDate;   // e.g. "15 Mar 2026"
  final int daysUntil;             // e.g. 349
  final String zodiacSign;         // e.g. "Pisces ♓"

  const BirthdayCountdownCard({
    super.key,
    required this.nextBirthdayDate,
    required this.daysUntil,
    required this.zodiacSign,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: AppColors.amber.withOpacity(0.2),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // ── Cake icon orb ────────────────────────────
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.amber.withOpacity(0.08),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.amber.withOpacity(0.25)),
            ),
            alignment: Alignment.center,
            child: const Text('🎂', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 14),

          // ── Next birthday info ───────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEXT BIRTHDAY',
                  style: AppText.fieldLabel.copyWith(
                    color: AppColors.amber.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(nextBirthdayDate, style: AppText.dateValue),
                const SizedBox(height: 2),
                Text(zodiacSign,
                    style: AppText.statLabel.copyWith(fontSize: 11)),
              ],
            ),
          ),

          // ── Days pill ────────────────────────────────
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.amber.withOpacity(0.08),
              border: Border.all(color: AppColors.amber.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(AppDimens.radiusField),
            ),
            child: Column(
              children: [
                Text(
                  '$daysUntil',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.amber,
                    height: 1,
                  ),
                ),
                Text(
                  'days',
                  style: AppText.statLabel.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}