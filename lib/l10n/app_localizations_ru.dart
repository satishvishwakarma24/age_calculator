// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'КОСМИЧЕСКИЙ ИССЛЕДОВАТЕЛЬ ВОЗРАСТА';

  @override
  String get splashDescription =>
      'Узнайте свой возраст в\nпространстве и времени';

  @override
  String get beginExploration => 'НАЧАТЬ ИССЛЕДОВАНИЕ  ↗';

  @override
  String get privacyNote => 'Данные не покидают ваше устройство';

  @override
  String get language => 'Язык';

  @override
  String get settings => 'Настройки';

  @override
  String get settingsSubtitle => 'Язык, тема и предпочтения';

  @override
  String get theme => 'Тема';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get navCalc => 'Расчёт';

  @override
  String get navPlanets => 'Планеты';

  @override
  String get navCompare => 'Сравнить';

  @override
  String get navMembers => 'Участники';

  @override
  String get navSettings => 'Настройки';
}
