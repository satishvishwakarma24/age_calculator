import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/section_card.dart';
import 'settings_controller.dart';
import 'settings_model.dart';

/// Settings tab: theme, date format and data reset.
class SettingsScreen extends StatelessWidget {
  /// Clears all persisted app data (age, birthdays and settings).
  final Future<void> Function() onResetAll;

  const SettingsScreen({super.key, required this.onResetAll});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return Column(children: [
      SectionCard(
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: settings.theme,
            decoration: const InputDecoration(labelText: 'Theme'),
            items: [
              for (final option in themeOptions)
                DropdownMenuItem(value: option.$1, child: Text(option.$2)),
            ],
            onChanged: (v) => settings.setTheme(v ?? 'system'),
          ),
          DropdownButtonFormField<String>(
            value: settings.format,
            decoration: const InputDecoration(labelText: 'Date format'),
            items: [
              for (final option in dateFormatOptions)
                DropdownMenuItem(value: option.$1, child: Text(option.$2)),
            ],
            onChanged: (v) => settings.setFormat(v ?? 'dmy'),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () => _confirmReset(context),
            icon: const Icon(Icons.delete_forever),
            label: const Text('Delete all saved data'),
          ),
        ]),
      ),
      const Text('Everything stays on this device. Planet ages are approximate.'),
    ]);
  }

  Future<void> _confirmReset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete all saved data?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete all')),
        ],
      ),
    );
    if (ok == true) await onResetAll();
  }
}
