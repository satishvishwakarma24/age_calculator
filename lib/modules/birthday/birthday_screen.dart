import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/section_card.dart';
import '../settings/settings_controller.dart';
import 'birthday_controller.dart';
import 'birthday_model.dart';

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
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        ),
      ),
      SizedBox(height: 3.h),
      FilledButton(
        onPressed: () => showBirthdayEditor(context, controller),
        child: const Text('Add birthday'),
      ),
      SizedBox(height: 3.h),
      if (people.isEmpty) const SectionCard(child: Text('No birthdays found.')),
      for (final person in people)
        SectionCard(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: InkWell(
            onTap: () => showBirthdayEditor(context, controller, existing: person),
            child: Row(children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor: _getAvatarColor(person.group),
                child: Text(
                  person.initial,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.dp,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.dp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      person.group,
                      style: TextStyle(color: AppColors.textSub, fontSize: 10.dp),
                    ),
                  ],
                ),
              ),
              Text(
                '${person.daysUntilNext} days',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.dp,
                  color: AppColors.accentTeal,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: AppColors.textSub, size: 5.w),
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
    // Guard: widget may have been unmounted while the dialog was open.
    if (ok == true && context.mounted) await controller.remove(person.id);
  }
}

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: nameController,
              maxLength: 40,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            SizedBox(height: 2.h),
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
            SizedBox(height: 2.h),
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
                padding: EdgeInsets.only(top: 1.h),
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
              SizedBox(width: 3.w),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final validation = validateDob(date);
                    if (name.isEmpty || validation != null) {
                      refresh(() => error = name.isEmpty ? 'Name is required' : validation!);
                      return;
                    }
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
