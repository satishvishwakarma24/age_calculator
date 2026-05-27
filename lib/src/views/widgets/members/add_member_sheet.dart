import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  AddMemberSheet
//  Modal bottom sheet for adding / editing a
//  saved member profile.
// ─────────────────────────────────────────────

class AddMemberSheet extends StatefulWidget {
  final void Function(String name, DateTime birthDate, String avatar) onSave;
  final VoidCallback? onDelete;
  final String? initialName;
  final DateTime? initialBirthDate;
  final String? initialAvatar;

  const AddMemberSheet({
    super.key,
    required this.onSave,
    this.onDelete,
    this.initialName,
    this.initialBirthDate,
    this.initialAvatar,
  });

  @override
  State<AddMemberSheet> createState() => _AddMemberSheetState();
}

class _AddMemberSheetState extends State<AddMemberSheet> {
  late final TextEditingController _nameCtrl;
  late DateTime? _birthDate;
  late String _selectedAvatar;

  static final _dobFormat = DateFormat('d MMM yyyy');

  static const _avatars = [
    '👨', '👩', '👧', '👦', '👴', '👵', '🧑', '👶',
    '🧔', '👱', '🧕', '🧒',
  ];

  bool get _isEdit => widget.initialName != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName ?? '');
    _birthDate = widget.initialBirthDate;
    _selectedAvatar = widget.initialAvatar ?? '👤';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4FC3F7),
              onPrimary: Color(0xFF050A18),
              surface: Color(0xFF0D1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0D1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) return;
    setState(() => _birthDate = DateTime(picked.year, picked.month, picked.day));
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty || _birthDate == null) return;
    widget.onSave(name, _birthDate!, _selectedAvatar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dobLabel = _birthDate == null
        ? 'Select date'
        : _dobFormat.format(_birthDate!);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgMid,
        border: Border.all(color: AppColors.glassBorder),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: AppDimens.paddingPage,
        right: AppDimens.paddingPage,
        top: AppDimens.paddingPage,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            _isEdit ? 'EDIT MEMBER' : 'ADD MEMBER',
            style: AppText.appBarTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppDimens.gapXl),

          Text('AVATAR', style: AppText.fieldLabel),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _avatars.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final av = _avatars[i];
                final selected = av == _selectedAvatar;
                return GestureDetector(
                  onTap: () => setState(() => _selectedAvatar = av),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.starBlue.withOpacity(0.12)
                          : AppColors.glassBlue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.starBlue
                            : AppColors.glassBorderWeak,
                        width: selected ? 1.5 : 0.8,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(av, style: const TextStyle(fontSize: 20)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimens.gapLg),

          Text('NAME', style: AppText.fieldLabel),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            style: AppText.dateValue,
            cursorColor: AppColors.starBlue,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle:
                  AppText.dateValue.copyWith(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.glassBlue,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusField),
                borderSide:
                    BorderSide(color: AppColors.glassBorder, width: 0.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusField),
                borderSide:
                    BorderSide(color: AppColors.glassBorder, width: 0.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusField),
                borderSide:
                    const BorderSide(color: AppColors.starBlue, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.gapLg),

          CosmicDateField(
            label: 'Date of Birth',
            value: dobLabel,
            accentColor: AppColors.lavender,
            onTap: _pickDob,
          ),
          const SizedBox(height: AppDimens.gapXl),

          CosmicButton(
            label: _isEdit ? 'SAVE CHANGES' : 'ADD TO COSMOS',
            gradient: AppGradients.ctaLavender,
            onPressed: _submit,
          ),

          if (_isEdit && widget.onDelete != null) ...[
            const SizedBox(height: AppDimens.gapMd),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onDelete!();
                },
                child: Text(
                  'Delete member',
                  style: AppText.statLabel.copyWith(
                    color: AppColors.mars,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
