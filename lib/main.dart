import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

Future<void> main() async {
// Ensure Flutter engine is ready before calling platform channels.
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app to portrait orientation only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const AgeCalcApp());
}
