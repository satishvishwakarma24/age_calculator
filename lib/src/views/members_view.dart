import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../utils/members_provider.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/members/member_card.dart';
import '../widgets/members/add_member_sheet.dart';

// ─────────────────────────────────────────────
//  MembersView
//  Saved profiles from SharedPreferences —
//  add, edit, pin, and delete members.
// ─────────────────────────────────────────────

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  void _showMemberSheet(
    BuildContext context, {
    String? memberId,
  }) {
    final members = context.read<MembersProvider>();
    final existing = memberId != null ? members.findById(memberId) : null;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => AddMemberSheet(
        initialName: existing?.name,
        initialBirthDate: existing?.birthDate,
        initialAvatar: existing?.avatar,
        onSave: (name, birthDate, avatar) {
          if (existing != null) {
            members.updateMember(
              id: existing.id,
              name: name,
              birthDate: birthDate,
              avatar: avatar,
            );
          } else {
            members.addMember(
              name: name,
              birthDate: birthDate,
              avatar: avatar,
            );
          }
        },
        onDelete: existing != null
            ? () => _confirmDelete(context, existing.id, existing.name)
            : null,
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    String id,
    String name,
  ) async {
    final members = context.read<MembersProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgMid,
        title: Text('Delete $name?', style: AppText.memberName),
        content: Text(
          'This profile will be removed from this device.',
          style: AppText.memberDetail,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: AppText.statLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Delete',
              style: AppText.statLabel.copyWith(color: AppColors.mars),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await members.deleteMember(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final members = context.watch<MembersProvider>();
    final profiles = members.displayMembers;
    final upcoming = members.upcomingBirthdays;

    return CosmicBackground(
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.paddingPage,
                      AppDimens.paddingPage,
                      AppDimens.paddingPage,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenHeader(
                          orb: CosmicOrb(
                            size: 44,
                            gradient: AppGradients.ctaLavender,
                            shadows: AppShadows.glowLavender(spread: 14),
                            child: const Icon(
                              Icons.group_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          title: 'Members',
                          subtitle:
                              '${members.count} saved profile${members.count == 1 ? '' : 's'}',
                        ),
                        const SizedBox(height: AppDimens.gapXl),
                        UpcomingBirthdayBanner(upcoming: upcoming),
                        if (profiles.isEmpty) ...[
                          GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No profiles yet',
                                  style: AppText.memberName,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Tap + to add family and friends. '
                                  'Their age and birthday countdown '
                                  'stay on this device.',
                                  style: AppText.memberDetail,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppDimens.gapMd),
                        ] else ...[
                          Text('ALL PROFILES', style: AppText.sectionTitle),
                          const SizedBox(height: AppDimens.gapSm),
                        ],
                      ],
                    ),
                  ),
                ),

                if (profiles.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      AppDimens.paddingPage,
                      0,
                      AppDimens.paddingPage,
                      AppDimens.paddingPage +
                          AppDimens.navBarHeight +
                          AppDimens.fabSize,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) {
                          final member = profiles[i];
                          return MemberCard(
                            member: member,
                            onTap: () =>
                                _showMemberSheet(context, memberId: member.id),
                            onLongPress: () async {
                              await context
                                  .read<MembersProvider>()
                                  .togglePin(member.id);
                            },
                          );
                        },
                        childCount: profiles.length,
                      ),
                    ),
                  )
                else
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: AppDimens.navBarHeight + AppDimens.fabSize,
                    ),
                  ),
              ],
            ),

            Positioned(
              right: AppDimens.paddingPage,
              bottom: AppDimens.navBarHeight + 16,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showMemberSheet(context),
                  customBorder: const CircleBorder(),
                  child: Ink(
                    width: AppDimens.fabSize,
                    height: AppDimens.fabSize,
                    decoration: BoxDecoration(
                      gradient: AppGradients.ctaLavender,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.glowLavender(spread: 18),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
