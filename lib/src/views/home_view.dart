import 'package:flutter/material.dart';
import 'package:age_calculator/core/theme/app_theme.dart';
import 'package:age_calculator/core/widgets/native_ad_widget.dart';
import '../widgets/common/cosmic_nav_bar.dart';
import 'calculator_view.dart';
import 'solar_system_view.dart';
import 'members_view.dart';
import 'settings_view.dart';

// ─────────────────────────────────────────────
//  HomeView
//  Shell that holds the bottom navigation bar
//  and switches between the four main screens
//  using an IndexedStack (preserves scroll pos
//  and animation state).
//
//  Tab indices: ( only 0 to 3 are implemented)
//    0 → CalculatorView
//    1 → SolarSystemView
//    2 → MembersView 
//    3 → SettingsView
//    ? → CompareView (coming soon - hidden for now)
// ─────────────────────────────────────────────

class HomeView extends StatefulWidget {
  final int initialIndex;

  const HomeView({super.key, this.initialIndex = 0});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int _currentIndex;

  static const _screens = [
    CalculatorView(),
    SolarSystemView(),
    MembersView(),
    SettingsView(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, _screens.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicTheme.of(context).scaffoldBackground,
      body: Stack(
        children: [
          // ── Tab content (IndexedStack keeps state) ──────
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // ── Bottom nav ──────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_currentIndex == 0) const NativeAdWidget(),
                CosmicNavBar(
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}