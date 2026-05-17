import 'package:flutter/material.dart';
import 'package:age_calculator/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────
//  CosmicNavBar
//  Custom bottom navigation bar with a glowing
//  active indicator pill.
//  Tab indices: 0=Calc  1=Planets  2=Members  3=Settings
//  Compare tab hidden until feature ships.
// ─────────────────────────────────────────────

class CosmicNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CosmicNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = [
    Icons.auto_awesome_rounded,
    Icons.public_rounded,
    Icons.group_rounded,
    Icons.settings_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cosmic = CosmicTheme.of(context);
    final labels = [
      l10n.navCalc,
      l10n.navPlanets,
      l10n.navMembers,
      l10n.navSettings,
    ];
    return Container(
      height: AppDimens.navBarHeight,
      decoration: BoxDecoration(
        color: cosmic.navBarBackground,
        border: Border(
          top: BorderSide(color: cosmic.glassBorder, width: 0.8),
        ),
      ),
      child: Row(
        children: List.generate(_icons.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.starBlue.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _icons[i],
                      size: 22,
                      color:
                          active ? AppColors.starBlue : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.3,
                      fontWeight: active
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: active ? AppColors.starBlue : cosmic.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}