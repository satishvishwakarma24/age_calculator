import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'age_calc_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AgeCalcApp());
}
