import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/locale_provider.dart';
import '../../core/widgets/section_card.dart';
import 'settings_controller.dart';
import 'settings_model.dart';

/// Settings tab: theme, language, date format and data reset.
class SettingsScreen extends StatelessWidget {
  /// Clears all persisted app data (age, birthdays and settings).
  final Future<void> Function() onResetAll;

  const SettingsScreen({super.key, required this.onResetAll});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final localeProvider = context.watch<LocaleProvider>();
    final currentLangCode = localeProvider.locale.languageCode;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
        // Hide for now: Theme is controlled by the system and cannot be changed in-app.
                  // // 1. Theme — live controlled DropdownButton
                  // _SettingsDropdown<String>(
                  //   label: 'Theme',
                  //   icon: Icons.palette_outlined,
                  //   value: settings.theme,
                  //   items: themeOptions
                  //       .map((o) => DropdownMenuItem(value: o.$1, child: Text(o.$2)))
                  //       .toList(),
                  //   onChanged: (v) => settings.setTheme(v ?? 'system'),
                  // ),
                  // const SizedBox(height: 20),

                  // 2. Language — live controlled DropdownButton
                  _SettingsDropdown<String>(
                    label: 'Language',
                    icon: Icons.language_outlined,
                    value: currentLangCode,
                    items: LocaleProvider.localeNames.entries
                        .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) localeProvider.setLocale(Locale(v));
                    },
                  ),
                  const SizedBox(height: 20),

                  // 3. Date Format — live controlled DropdownButton
                  _SettingsDropdown<String>(
                    label: 'Date format',
                    icon: Icons.calendar_month_outlined,
                    value: settings.format,
                    items: dateFormatOptions
                        .map((o) => DropdownMenuItem(value: o.$1, child: Text(o.$2)))
                        .toList(),
                    onChanged: (v) => settings.setFormat(v ?? 'ddmmyy'),
                  ),
                  const SizedBox(height: 24),

                  // 4. Destructive Action — Clear all data
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _confirmReset(context),
                    icon: const Icon(Icons.delete_forever),
                    label: const Text(
                      'Delete all saved data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 5. Privacy Footer Information Panel
          const Text(
            'Everything stays on this device.\nPlanet ages are approximate.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete all saved data?'),
        content: const Text(
          'This action is permanent. All your calculated ages, birthdays, and preferences will be wiped.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Delete all'),
          ),
        ],
      ),
    );
    // Guard: widget may have been unmounted while the dialog was open.
    if (ok == true && context.mounted) await onResetAll();
  }
}

/// A fully-controlled dropdown wrapped in an InputDecorator so it matches
/// the app's OutlineInputBorder style and reacts to live state changes.
class _SettingsDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _SettingsDropdown({
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.brightness == Brightness.dark
        ? theme.dividerColor
        : Colors.grey.shade400;

    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
