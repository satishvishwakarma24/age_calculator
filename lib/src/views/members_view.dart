import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/members/member_card.dart';
import '../widgets/members/add_member_sheet.dart';

// ─────────────────────────────────────────────
//  MembersView
//  Displays saved profiles, birthday banner,
//  and a FAB to add new members.
// ─────────────────────────────────────────────

class MembersView extends StatefulWidget {
  const MembersView({super.key});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  // Placeholder members — Phase 2 will load from local storage
  final List<MemberData> _members = const [
    MemberData(
      id: '1',
      name: 'Alice Chen',
      avatar: '👩',
      dobFormatted: '15 Mar 1992',
      ageLabel: '33 yrs',
      accentColor: AppColors.tealAccent,
      isPinned: true,
      birthdayIn: '13 days',
    ),
    MemberData(
      id: '2',
      name: 'Bob Smith',
      avatar: '👨',
      dobFormatted: '30 Nov 1988',
      ageLabel: '37 yrs',
      accentColor: AppColors.lavender,
    ),
    MemberData(
      id: '3',
      name: 'Sophie',
      avatar: '👧',
      dobFormatted: '04 Jul 2018',
      ageLabel: '7 yrs',
      accentColor: AppColors.amber,
    ),
  ];

  List<MemberData> get _upcomingBirthdays =>
      _members.where((m) => m.birthdayIn != null).toList();

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMemberSheet(
        onSave: (name, dob, avatar) {
          // Phase 2: persist via MembersController
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: Stack(
          children: [
            // ── Main scroll ────────────────────────────────
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
                        // Header
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
                              '${_members.length} saved profiles',
                        ),
                        const SizedBox(height: AppDimens.gapXl),

                        // Upcoming birthdays banner
                        UpcomingBirthdayBanner(
                            upcoming: _upcomingBirthdays),

                        // Section label
                        Text('ALL PROFILES', style: AppText.sectionTitle),
                        const SizedBox(height: AppDimens.gapSm),
                      ],
                    ),
                  ),
                ),

                // Member list
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
                      (ctx, i) => MemberCard(
                        member: _members[i],
                        onTap: () {
                          // Phase 2: navigate to member detail
                        },
                      ),
                      childCount: _members.length,
                    ),
                  ),
                ),
              ],
            ),

            // ── FAB ────────────────────────────────────────
            Positioned(
              right: AppDimens.paddingPage,
              bottom: AppDimens.navBarHeight + 16,
              child: GestureDetector(
                onTap: _showAddSheet,
                child: Container(
                  width: AppDimens.fabSize,
                  height: AppDimens.fabSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.ctaLavender,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.glowLavender(spread: 18),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 28,
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