import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/date_utils.dart';
import '../../core/widgets/section_card.dart';
import '../settings/settings_controller.dart';
import 'birthday_controller.dart';
import 'birthday_model.dart';

/// Birthdays tab: list, search and manage saved birthdays.
class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BirthdayController>();
    final format = context.watch<SettingsController>().format;
    final people = controller.visible;

    return Column(children: [
      TextField(
        onChanged: controller.setSearch,
        decoration: const InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 12),
      FilledButton.icon(
        onPressed: () => showBirthdayEditor(context, controller),
        icon: const Icon(Icons.add),
        label: const Text('Add birthday'),
      ),
      const SizedBox(height: 12),
      if (people.isEmpty) const SectionCard(child: Text('No birthdays found.')),
      for (final person in people)
        SectionCard(
          child: Row(children: [
            CircleAvatar(child: Text(person.initial)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(person.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${person.group} · ${formatDate(person.date, format)}'),
                  Text('${person.daysUntilNext} days remaining'),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Edit birthday',
              onPressed: () => showBirthdayEditor(context, controller, existing: person),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: 'Delete birthday',
              onPressed: () => _confirmDelete(context, controller, person),
              icon: const Icon(Icons.delete_outline),
            ),
          ]),
        ),
    ]);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    BirthdayController controller,
    Person person,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete birthday?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok == true) await controller.remove(person.id);
  }
}

/// Opens the add/edit birthday dialog. [preset] pre-fills the date (used by the
/// Age tab's "Save to birthdays" action).
Future<void> showBirthdayEditor(
  BuildContext context,
  BirthdayController controller, {
  Person? existing,
  DateTime? preset,
}) async {
  final nameController = TextEditingController(text: existing?.name ?? '');
  final format = context.read<SettingsController>().format;
  DateTime? date = existing?.date ?? preset;
  String group = existing?.group ?? birthdayGroups.first;
  String error = '';

  final result = await showDialog<Person>(
    context: context,
    builder: (c) => StatefulBuilder(
      builder: (c, refresh) => AlertDialog(
        title: Text(existing == null ? 'Add birthday' : 'Edit birthday'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: nameController,
              maxLength: 40,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: c,
                  initialDate: date ?? now,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) refresh(() => date = dateOnly(picked));
              },
              icon: const Icon(Icons.calendar_month),
              label: Text(date == null ? 'Date of birth' : formatDate(date!, format)),
            ),
            DropdownButtonFormField<String>(
              value: group,
              decoration: const InputDecoration(labelText: 'Group'),
              items: birthdayGroups
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (v) => refresh(() => group = v ?? group),
            ),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.redAccent)),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final validation = validateDob(date);
              if (name.isEmpty || validation != null) {
                refresh(() => error =
                    name.isEmpty ? 'Name is required' : validation!);
                return;
              }
              Navigator.pop(
                c,
                Person(
                  id: existing?.id ??
                      DateTime.now().microsecondsSinceEpoch.toString(),
                  name: name,
                  group: group,
                  date: date!,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
  nameController.dispose();

  if (result == null) return;
  if (existing == null) {
    await controller.add(result);
  } else {
    await controller.update(existing.id, result);
  }
}
