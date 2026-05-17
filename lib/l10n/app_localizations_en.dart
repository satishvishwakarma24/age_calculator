// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'COSMIC AGE EXPLORER';

  @override
  String get splashDescription => 'Discover your age across\nspace and time';

  @override
  String get beginExploration => 'BEGIN EXPLORATION  ↗';

  @override
  String get privacyNote => 'No data leaves your device';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Language, theme & preferences';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get navCalc => 'Calc';

  @override
  String get navPlanets => 'Planets';

  @override
  String get navCompare => 'Compare';

  @override
  String get navMembers => 'Members';

  @override
  String get navSettings => 'Settings';
}
