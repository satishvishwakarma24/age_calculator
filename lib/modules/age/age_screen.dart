import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/date_picker_field.dart';
import '../../core/widgets/section_card.dart';
import '../birthday/birthday_controller.dart';
import '../birthday/birthday_screen.dart';
import '../settings/settings_controller.dart';
import 'age_controller.dart';

class AgeScreen extends StatelessWidget {
  const AgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final age = context.watch<AgeController>();
    final format = context.watch<SettingsController>().format;
    final result = age.result;
    final upcoming = age.upcoming;
    final numberFormat = NumberFormat('#,###');

    return Column(children: [
      SectionCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          DatePickerField(
            label: 'Date of birth',
            value: age.dob,
            format: format,
            onChanged: age.setDob,
          ),
          DatePickerField(
            label: 'Age on (optional)',
            value: age.asOf,
            format: format,
            onChanged: age.setAsOf,
          ),
          if (age.asOf != null)
            TextButton(onPressed: age.clearAsOf, child: const Text('Clear Age on')),
          if (age.error != null)
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Text(age.error!, style: const TextStyle(color: Colors.redAccent)),
            ),
          FilledButton(onPressed: age.calculate, child: const Text('Calculate age')),
        ]),
      ),
      if (result != null && upcoming != null) ...[
        SizedBox(height: 2.h),
        Row(children: [
          _ResultCard(value: result.years.toString(), label: 'years'),
          SizedBox(width: 3.w),
          _ResultCard(value: result.months.toString(), label: 'months'),
          SizedBox(width: 3.w),
          _ResultCard(value: result.days.toString(), label: 'days'),
        ]),
        SizedBox(height: 3.h),
        Text(
          '${numberFormat.format(result.totalDays)} days · ${numberFormat.format(result.totalWeeks)} weeks · ${numberFormat.format(result.totalHours)} hours lived',
          style: TextStyle(color: AppColors.textSub, fontSize: 10.dp),
        ),
        SizedBox(height: 3.h),
        SectionCard(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                upcoming.daysUntil.toString(),
                style: TextStyle(
                  fontSize: 36.dp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentTeal,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  'days to your\nnext birthday',
                  style: TextStyle(
                    fontSize: 14.dp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'Turning ${upcoming.turningAge} on ${formatDate(upcoming.date, format)}',
          style: TextStyle(color: AppColors.textSub, fontSize: 11.dp),
        ),
        SizedBox(height: 3.h),
        OutlinedButton(
          onPressed: () => showBirthdayEditor(
            context,
            context.read<BirthdayController>(),
            preset: age.dob,
          ),
          child: const Text('Save to birthdays'),
        ),
      ],
    ]);
  }
}

class _ResultCard extends StatelessWidget {
  final String value;
  final String label;

  const _ResultCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5.h),
        decoration: BoxDecoration(
          color: isDark ? theme.cardTheme.color : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? theme.dividerColor : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24.dp,
              fontWeight: FontWeight.bold,
              color: AppColors.accentTeal,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.textSub, fontSize: 11.dp),
          ),
        ]),
      ),
    );
  }
}
