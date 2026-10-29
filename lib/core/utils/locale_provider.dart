import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';

/// Persists and exposes the active app locale.
class LocaleProvider extends ChangeNotifier {
  static const _key = 'app_locale';

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static const Map<String, String> localeNames = {
    'en': 'English',
    'es': 'Español',
    'hi': 'हिन्दी',
    'zh': '中文',
    'ar': 'العربية',
    'fr': 'Français',
    'pt': 'Português',
    'ru': 'Русский',
    'de': 'Deutsch',
    'id': 'Indonesia',
    'ja': '日本語',
  };

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key);
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    final isSupported = supportedLocales
        .any((s) => s.languageCode == locale.languageCode);
    if (!isSupported) return;
    if (_locale.languageCode == locale.languageCode) return; // already set
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }
}
