import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';

/// Owns theme and date-format preferences and persists them.
class SettingsController extends ChangeNotifier {
  static const String themeKey = 'theme';
  static const String formatKey = 'format';

  AppSettings _settings = const AppSettings();

  AppSettings get settings => _settings;

  String get theme => _settings.theme;

  String get format => _settings.format;

  ThemeMode get themeMode {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  SettingsController() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = AppSettings(
      theme: prefs.getString(themeKey) ?? 'system',
      format: prefs.getString(formatKey) ?? 'dmy',
    );
    notifyListeners();
  }

  Future<void> setTheme(String value) async {
    if (_settings.theme == value) return;
    _settings = _settings.copyWith(theme: value);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, value);
  }

  Future<void> setFormat(String value) async {
    if (_settings.format == value) return;
    _settings = _settings.copyWith(format: value);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(formatKey, value);
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(themeKey);
    await prefs.remove(formatKey);
    _settings = const AppSettings();
    notifyListeners();
  }
}
