import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/date_utils.dart';
import '../../core/widgets/date_picker_field.dart';
import '../../core/widgets/section_card.dart';
import '../birthday/birthday_controller.dart';
import '../birthday/birthday_screen.dart';
import '../settings/settings_controller.dart';
import 'age_controller.dart';

/// Age tab: pick a date of birth and show the computed age.
class AgeScreen extends StatelessWidget {
  const AgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final age = context.watch<AgeController>();
    final format = context.watch<SettingsController>().format;
    final result = age.result;
    final upcoming = age.upcoming;

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
            Text(age.error!, style: const TextStyle(color: Colors.redAccent)),
          FilledButton(onPressed: age.calculate, child: const Text('Calculate age')),
        ]),
      ),
      if (result != null && upcoming != null) ...[
        SectionCard(
          child: Column(children: [
            Row(children: [
              for (final i in [0, 1, 2])
                Expanded(
                  child: Column(children: [
                    Text(
                      [result.years, result.months, result.days][i].toString(),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color(0xFF5CE1E6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(['years', 'months', 'days'][i]),
                  ]),
                ),
            ]),
            const SizedBox(height: 12),
            Text('${result.totalDays} days · '
                '${result.totalWeeks} weeks · '
                '${result.totalHours} hours lived'),
          ]),
        ),
        SectionCard(
          child: Text('${upcoming.daysUntil} days to next birthday · '
              'Turning ${upcoming.turningAge} on ${formatDate(upcoming.date, format)}'),
        ),
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
