import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'config/routes/app_router.dart';
import 'core/widgets/app_open_ad_widget.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'modules/age/age_controller.dart';
import 'modules/birthday/birthday_controller.dart';
import 'modules/planets/planets_controller.dart';
import 'modules/settings/settings_controller.dart';
import 'core/utils/locale_provider.dart';

class AgeCalcApp extends StatelessWidget {
  const AgeCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgeController()),
        ChangeNotifierProvider(create: (_) => BirthdayController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        Provider(create: (_) => const PlanetsController()),
      ],
      child: FlutterSizer(
        builder: (context, orientation, screenType) {
          return const _AgeCalcAppView();
        },
      ),
    );
  }
}

class _AgeCalcAppView extends StatelessWidget {
  const _AgeCalcAppView();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final localeProvider = context.watch<LocaleProvider>();

    return AppOpenAdWidget(
      child: MaterialApp(
        title: 'Age Calc',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: settings.themeMode,
        locale: localeProvider.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        builder: (context, child) {
          _applySystemChrome(Theme.of(context).brightness);
          return child ?? const SizedBox.shrink();
        },
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
        onUnknownRoute: AppRouter.onUnknownRoute,
      ),
    );
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
