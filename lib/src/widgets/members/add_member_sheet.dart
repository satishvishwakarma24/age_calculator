import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  AddMemberSheet
//  Modal bottom sheet for adding / editing a
//  saved member profile.
//
//  Usage:
//    showModalBottomSheet(
//      context: context,
//      isScrollControlled: true,
//      backgroundColor: Colors.transparent,
//      builder: (_) => AddMemberSheet(onSave: (name, dob) { ... }),
//    );
// ─────────────────────────────────────────────

class AddMemberSheet extends StatefulWidget {
  final void Function(String name, String dob, String avatar) onSave;
  final String? initialName;
  final String? initialDob;
  final String? initialAvatar;

  const AddMemberSheet({
    super.key,
    required this.onSave,
    this.initialName,
    this.initialDob,
    this.initialAvatar,
  });

  @override
  State<AddMemberSheet> createState() => _AddMemberSheetState();
}

class _AddMemberSheetState extends State<AddMemberSheet> {
  late final TextEditingController _nameCtrl;
  String _selectedDob = '';
  String _selectedAvatar = '👤';

  static const _avatars = [
    '👨', '👩', '👧', '👦', '👴', '👵', '🧑', '👶',
    '🧔', '👱', '🧕', '🧒',
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName ?? '');
    _selectedDob = widget.initialDob ?? '';
    _selectedAvatar = widget.initialAvatar ?? '👤';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _pickDob() {
    // Phase 2: launch CupertinoDatePicker or showDatePicker
    setState(() => _selectedDob = '01 Jan 2000');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialName != null;

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
          // ── Handle ──────────────────────────────────────
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

          // ── Title ────────────────────────────────────────
          Text(
            isEdit ? 'EDIT MEMBER' : 'ADD MEMBER',
            style: AppText.appBarTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppDimens.gapXl),

          // ── Avatar picker ─────────────────────────────────
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
                    child: Text(av,
                        style: const TextStyle(fontSize: 20)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimens.gapLg),

          // ── Name field ────────────────────────────────────
          Text('NAME', style: AppText.fieldLabel),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            style: AppText.dateValue,
            cursorColor: AppColors.starBlue,
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle: AppText.dateValue
                  .copyWith(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.glassBlue,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimens.radiusField),
                borderSide: BorderSide(
                    color: AppColors.glassBorder, width: 0.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimens.radiusField),
                borderSide: BorderSide(
                    color: AppColors.glassBorder, width: 0.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimens.radiusField),
                borderSide:
                    const BorderSide(color: AppColors.starBlue, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.gapLg),

          // ── DOB picker ────────────────────────────────────
          CosmicDateField(
            label: 'Date of Birth',
            value: _selectedDob.isEmpty ? 'Select date' : _selectedDob,
            onTap: _pickDob,
          ),
          const SizedBox(height: AppDimens.gapXl),

          // ── Save button ───────────────────────────────────
          CosmicButton(
            label: isEdit ? 'SAVE CHANGES' : 'ADD TO COSMOS',
            gradient: AppGradients.ctaLavender,
            onPressed: () {
              if (_nameCtrl.text.trim().isNotEmpty &&
                  _selectedDob.isNotEmpty) {
                widget.onSave(
                  _nameCtrl.text.trim(),
                  _selectedDob,
                  _selectedAvatar,
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}