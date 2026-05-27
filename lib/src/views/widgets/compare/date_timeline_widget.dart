import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────
//  DateTimelineBadge
//  Shows a single date as a small badge
//  (day number + month/year label).
// ─────────────────────────────────────────────

class DateTimelineBadge extends StatelessWidget {
  final String day;
  final String monthYear;
  final Color accentColor;

  const DateTimelineBadge({
    super.key,
    required this.day,
    required this.monthYear,
    this.accentColor = AppColors.starBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        border: Border.all(color: accentColor.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(AppDimens.radiusField),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: accentColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            monthYear,
            style: AppText.statLabel.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DateTimeline
//  Horizontal row: from-badge ── gradient line ── to-badge
// ─────────────────────────────────────────────

class DateTimeline extends StatelessWidget {
  final String fromDay;
  final String fromMonthYear;
  final String toDay;
  final String toMonthYear;

  const DateTimeline({
    super.key,
    required this.fromDay,
    required this.fromMonthYear,
    required this.toDay,
    required this.toMonthYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DateTimelineBadge(
          day: fromDay,
          monthYear: fromMonthYear,
          accentColor: AppColors.tealAccent,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 2,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.tealAccent, AppColors.lavender],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        DateTimelineBadge(
          day: toDay,
          monthYear: toMonthYear,
          accentColor: AppColors.lavender,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  DiffDisplay
//  Large years · months · days difference row
// ─────────────────────────────────────────────

class DiffDisplay extends StatelessWidget {
  final int years;
  final int months;
  final int days;

  const DiffDisplay({
    super.key,
    required this.years,
    required this.months,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _DiffUnit(value: '$years', label: 'YEARS',
            color: AppColors.tealAccent),
        _Dot(),
        _DiffUnit(value: '$months', label: 'MONTHS',
            color: AppColors.lavender),
        _Dot(),
        _DiffUnit(value: '$days', label: 'DAYS',
            color: AppColors.starBlue),
      ],
    );
  }
}

class _DiffUnit extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _DiffUnit({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppText.diffNumber.copyWith(color: color),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppText.statLabel),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 28,
          color: AppColors.textMuted,
          height: 1.2,
        ),
      ),
    );
  }
}