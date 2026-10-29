import 'package:flutter/material.dart';

import '../utils/date_utils.dart';

/// Labelled button that opens a date picker and reports the picked date.
class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String format;
  final ValueChanged<DateTime> onChanged;

  const DatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.format,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(label),
        OutlinedButton.icon(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? now,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (picked != null) onChanged(dateOnly(picked));
          },
          icon: const Icon(Icons.calendar_month),
          label: Text(value == null ? 'Select date' : formatDate(value!, format)),
        ),
        const SizedBox(height: 14),
      ]);
}
