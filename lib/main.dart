import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'config/services/ads_service.dart';
import 'core/theme/theme_provider.dart';
import 'src/provider/age_calculator_provider.dart';
import 'core/utils/locale_provider.dart';
import 'src/provider/members_provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF050A18),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  FlutterNativeSplash.remove();

  await AdsService.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AgeCalculatorProvider()),
        ChangeNotifierProvider(create: (_) => MembersProvider()),
      ],
      child: const AgeCalcApp(),
    ),
  );
}
