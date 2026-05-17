import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  AgeResultCard
//  Large hero result display:
//    • Big animated year number with glow
//    • Months + days secondary line
//    • Three stat chips: total days / months / hours
// ─────────────────────────────────────────────

class AgeResultCard extends StatelessWidget {
  final int years;
  final int months;
  final int days;
  final int totalDays;
  final int totalMonths;
  final int totalHours;

  const AgeResultCard({
    super.key,
    required this.years,
    required this.months,
    required this.days,
    required this.totalDays,
    required this.totalMonths,
    required this.totalHours,
  });

  String _formatLarge(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(0)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          // ── Label ─────────────────────────────────────
          Text(
            'YOUR AGE',
            style: AppText.screenLabel.copyWith(letterSpacing: 2),
          ),
          const SizedBox(height: 8),

          // ── Big year number ───────────────────────────
          Text(
            '$years',
            style: AppText.resultBig.copyWith(
              shadows: [
                Shadow(
                  color: AppColors.starBlue.withOpacity(0.7),
                  blurRadius: 28,
                ),
              ],
            ),
          ),
          Text('years', style: AppText.resultUnit),
          const SizedBox(height: 8),

          // ── Months · Days secondary ───────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SubStat(
                value: '$months',
                unit: 'mo',
                color: AppColors.lavender,
              ),
              const SizedBox(width: 20),
              _SubStat(
                value: '$days',
                unit: 'days',
                color: AppColors.tealAccent,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Three stat chips ──────────────────────────
          Row(
            children: [
              StatChip(
                value: _formatLarge(totalDays),
                label: 'Days',
                valueColor: AppColors.starBlue,
                borderColor: AppColors.glassBorder,
              ),
              const SizedBox(width: 8),
              StatChip(
                value: _formatLarge(totalMonths),
                label: 'Months',
                valueColor: AppColors.lavender,
                borderColor: AppColors.lavender.withOpacity(0.2),
              ),
              const SizedBox(width: 8),
              StatChip(
                value: _formatLarge(totalHours),
                label: 'Hours',
                valueColor: AppColors.amber,
                borderColor: AppColors.amber.withOpacity(0.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubStat extends StatelessWidget {
  final String value;
  final String unit;
  final Color color;

  const _SubStat({
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          unit,
          style: AppText.statLabel.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}