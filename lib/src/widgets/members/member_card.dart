import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  MemberCard
//  Displays a saved profile with avatar, name,
//  DOB, age tag, and optional birthday countdown.
// ─────────────────────────────────────────────

class MemberCard extends StatelessWidget {
  final MemberData member;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MemberCard({
    super.key,
    required this.member,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.gapSm),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: member.accentColor.withOpacity(0.03),
          border: Border.all(color: member.accentColor.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(AppDimens.radiusCard),
        ),
        child: Row(
          children: [
            // ── Avatar ──────────────────────────────────
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: member.accentColor.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                    color: member.accentColor.withOpacity(0.3)),
              ),
              alignment: Alignment.center,
              child: Text(member.avatar, style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),

            // ── Info ─────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(member.name, style: AppText.memberName),
                      if (member.isPinned) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.push_pin_rounded,
                            size: 13,
                            color: AppColors.starBlue.withOpacity(0.6)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(member.dobFormatted, style: AppText.memberDetail),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      CosmicTag(
                        label: member.ageLabel,
                        color: member.accentColor,
                      ),
                      if (member.birthdayIn != null)
                        CosmicTag(
                          label: '🎂 ${member.birthdayIn}',
                          color: AppColors.amber,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Chevron ──────────────────────────────────
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted.withOpacity(0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  UpcomingBirthdayBanner
//  Amber-tinted banner listing the nearest
//  upcoming birthday member(s).
// ─────────────────────────────────────────────

class UpcomingBirthdayBanner extends StatelessWidget {
  final List<MemberData> upcoming; // members with birthdayIn != null

  const UpcomingBirthdayBanner({super.key, required this.upcoming});

  @override
  Widget build(BuildContext context) {
    if (upcoming.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.gapMd),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.amber.withOpacity(0.06),
        border: Border.all(color: AppColors.amber.withOpacity(0.22)),
        borderRadius: BorderRadius.circular(AppDimens.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎂  UPCOMING BIRTHDAYS',
            style: AppText.fieldLabel.copyWith(
              color: AppColors.amber.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 10),
          ...upcoming.map((m) => _BannerRow(member: m)),
        ],
      ),
    );
  }
}

class _BannerRow extends StatelessWidget {
  final MemberData member;
  const _BannerRow({required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: member.accentColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(member.avatar,
                style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(member.name, style: AppText.memberName),
          ),
          CosmicTag(
            label: 'In ${member.birthdayIn}',
            color: AppColors.amber,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MemberData — display model
// ─────────────────────────────────────────────

class MemberData {
  final String id;
  final String name;
  final String avatar;         // emoji or initials
  final String dobFormatted;
  final String ageLabel;       // e.g. "33 yrs"
  final Color accentColor;
  final bool isPinned;
  final String? birthdayIn;    // e.g. "13 days" or null

  const MemberData({
    required this.id,
    required this.name,
    required this.avatar,
    required this.dobFormatted,
    required this.ageLabel,
    required this.accentColor,
    this.isPinned = false,
    this.birthdayIn,
  });
}