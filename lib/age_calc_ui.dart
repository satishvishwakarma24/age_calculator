import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'modules/age/age_controller.dart';
import 'modules/age/age_screen.dart';
import 'modules/birthday/birthday_controller.dart';
import 'modules/birthday/birthday_screen.dart';
import 'modules/planets/planets_controller.dart';
import 'modules/planets/planets_screen.dart';
import 'modules/settings/settings_controller.dart';
import 'modules/settings/settings_screen.dart';

/// Composition root: provides the feature controllers and renders the tab shell.
class AgeCalcApp extends StatelessWidget {
  const AgeCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgeController()),
        ChangeNotifierProvider(create: (_) => BirthdayController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        Provider(create: (_) => const PlanetsController()),
      ],
      child: const _AppShell(),
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  static const List<String> _titles = [
    'Your age',
    'Birthdays',
    'Age on other planets',
    'Settings',
  ];

  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<SettingsController>().themeMode;

    return MaterialApp(
      title: 'Age Calc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      builder: (context, child) {
        _applySystemChrome(Theme.of(context).brightness);
        return child ?? const SizedBox.shrink();
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.public, size: 20, color: AppColors.primaryPurple),
              SizedBox(width: 8),
              Text('Age Calc'),
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
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
            NavigationDestination(icon: Icon(Icons.cake_outlined), label: 'Birthdays'),
            NavigationDestination(icon: Icon(Icons.public), label: 'Planets'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
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
    await age.clear();
    await birthdays.clear();
    await settings.reset();
  }

  void _applySystemChrome(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? const Color(0xFF050A18) : AppColors.background,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }
}
