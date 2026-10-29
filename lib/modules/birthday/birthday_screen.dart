import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/section_card.dart';
import '../settings/settings_controller.dart';
import 'birthday_controller.dart';
import 'birthday_model.dart';

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

class BirthdayScreen extends StatelessWidget {

  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BirthdayController>();
    final people = controller.visible;

    return Column(children: [
      TextField(
        onChanged: controller.setSearch,
        decoration: InputDecoration(
          hintText: 'Search by name or group',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSub),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      const SizedBox(height: 24),
      FilledButton(
        onPressed: () => showBirthdayEditor(context, controller),
        child: const Text('Add birthday'),
      ),
      const SizedBox(height: 24),
      if (people.isEmpty) const SectionCard(child: Text('No birthdays found.')),
      for (final person in people)
        SectionCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: InkWell(
            onTap: () => showBirthdayEditor(context, controller, existing: person),
            child: Row(children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: _getAvatarColor(person.group),
                child: Text(
                  person.initial,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      person.group,
                      style: const TextStyle(color: AppColors.textSub, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                '${person.daysUntilNext} days',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.accentTeal,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.textSub, size: 20),
                onPressed: () => _confirmDelete(context, controller, person),
              ),
            ]),
          ),
        ),
    ]);
  }

  Color _getAvatarColor(String group) {
    switch (group.toLowerCase()) {
      case 'family':
        return const Color(0xFF7C5CFF);
      case 'friend':
        return const Color(0xFF5CE1E6);
      case 'work':
        return const Color(0xFF4A90E2);
      default:
        return const Color(0xFF3D5070);
    }
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
        content: Text('Are you sure you want to delete ${person.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (ok == true) await controller.remove(person.id);
  }
}

Future<void> showBirthdayEditor(
  BuildContext context,
  BirthdayController controller, {
  Person? existing,
  DateTime? preset,
}) async {
  _debugReport('birthday-editor-start', {'existing': existing?.id, 'preset': preset?.toIso8601String()});
  final nameController = TextEditingController(text: existing?.name ?? '');
  final format = context.read<SettingsController>().format;
  DateTime? date = existing?.date ?? preset;
  String group = existing?.group ?? birthdayGroups.first;
  String error = '';

  final result = await showDialog<Person>(
    context: context,
    builder: (c) {
      _debugReport('birthday-dialog-build', {});
      return StatefulBuilder(
        builder: (c, refresh) => AlertDialog(
          title: Text(existing == null ? 'Add birthday' : 'Edit birthday'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: nameController,
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  _debugReport('birthday-datepicker-open', {});
                  final picked = await showDatePicker(
                    context: c,
                    initialDate: date ?? now,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _debugReport('birthday-datepicker-picked', {'date': picked.toIso8601String()});
                    refresh(() => date = dateOnly(picked));
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(date == null ? 'Date of birth' : formatDate(date!, format)),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
              value: group,
              decoration: const InputDecoration(hintText: 'Group'),
                items: birthdayGroups
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => refresh(() => group = v ?? group),
              ),
              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(error, style: const TextStyle(color: Colors.redAccent)),
                ),
            ]),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(c),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      _debugReport('birthday-dialog-save-press', {'name': nameController.text});
                      final name = nameController.text.trim();
                      final validation = validateDob(date);
                      if (name.isEmpty || validation != null) {
                        _debugReport('birthday-dialog-save-invalid', {'error': validation});
                        refresh(() => error = name.isEmpty ? 'Name is required' : validation!);
                        return;
                      }
                      _debugReport('birthday-dialog-save-success', {'name': name, 'date': date?.toIso8601String()});
                      Navigator.pop(
                        c,
                        Person(
                          id: existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
                          name: name,
                          group: group,
                          date: date!,
                        ),
                      );
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
  _debugReport('birthday-dialog-closed', {'result': result?.id});
  nameController.dispose();

  if (result == null) return;
  if (existing == null) {
    _debugReport('birthday-controller-add', {'id': result.id});
    await controller.add(result);
  } else {
    _debugReport('birthday-controller-update', {'id': result.id});
    await controller.update(existing.id, result);
  }
}
