import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/date_picker_field.dart';
import '../../core/widgets/section_card.dart';
import '../birthday/birthday_controller.dart';
import '../birthday/birthday_screen.dart';
import '../settings/settings_controller.dart';
import 'age_controller.dart';

import 'dart:io';
import 'dart:convert';

void _debugReport(String id, dynamic data) {
  try {
    final client = HttpClient();
    client.postUrl(Uri.parse('http://192.168.1.5:7777/event')).then((req) {
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(jsonEncode({
        'sessionId': 'birthday-save-crash',
        'pointId': id,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      })));
      req.close();
    });
  } catch (_) {}
}

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
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(age.error!, style: const TextStyle(color: Colors.redAccent)),
            ),
          FilledButton(onPressed: age.calculate, child: const Text('Calculate age')),
        ]),
      ),
      if (result != null && upcoming != null) ...[
        const SizedBox(height: 16),
        Row(children: [
          _ResultCard(value: result.years.toString(), label: 'years'),
          const SizedBox(width: 12),
          _ResultCard(value: result.months.toString(), label: 'months'),
          const SizedBox(width: 12),
          _ResultCard(value: result.days.toString(), label: 'days'),
        ]),
        const SizedBox(height: 24),
        Text(
          '${numberFormat.format(result.totalDays)} days · ${numberFormat.format(result.totalWeeks)} weeks · ${numberFormat.format(result.totalHours)} hours lived',
          style: const TextStyle(color: AppColors.textSub, fontSize: 13),
        ),
        const SizedBox(height: 24),
        SectionCard(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                upcoming.daysUntil.toString(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentTeal,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'days to your\nnext birthday',
                  style: TextStyle(
                    fontSize: 18,
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
          style: const TextStyle(color: AppColors.textSub, fontSize: 14),
        ),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () {
            _debugReport('age-screen-save-start', {'dob': age.dob?.toIso8601String()});
            showBirthdayEditor(
              context,
              context.read<BirthdayController>(),
              preset: age.dob,
            );
          },
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
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.accentTeal,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSub, fontSize: 14),
          ),
        ]),
      ),
    );
  }
}
