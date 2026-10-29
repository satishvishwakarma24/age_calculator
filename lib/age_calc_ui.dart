import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/locale_provider.dart';
import 'modules/age/age_controller.dart';
import 'modules/age/age_screen.dart';
import 'modules/birthday/birthday_controller.dart';
import 'modules/birthday/birthday_screen.dart';
import 'modules/planets/planets_screen.dart';
import 'modules/settings/settings_controller.dart';
import 'modules/settings/settings_screen.dart';

/// The main application shell with tab navigation.
class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const List<String> _titles = [
    'Your age',
    'Birthdays',
    'Age on other planets',
    'Settings',
  ];

  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/app-icon-512.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Age Calc'),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          key: ValueKey(_tab),
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              _titles[_tab],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _pageFor(_tab),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.access_time), label: 'Age'),
          NavigationDestination(
              icon: Icon(Icons.cake_outlined), label: 'Birthdays'),
          NavigationDestination(icon: Icon(Icons.public), label: 'Planets'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _pageFor(int tab) {
    switch (tab) {
      case 1:
        return const BirthdayScreen();
      case 2:
        return const PlanetsScreen();
      case 3:
        return SettingsScreen(onResetAll: _resetAll);
      default:
        return const AgeScreen();
    }
  }

  Future<void> _resetAll() async {
    final age = context.read<AgeController>();
    final birthdays = context.read<BirthdayController>();
    final settings = context.read<SettingsController>();
    final locale = context.read<LocaleProvider>();
    await age.clear();
    await birthdays.clear();
    await settings.reset();
    await locale.setLocale(const Locale('en'));
  }
}
