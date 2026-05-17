// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'EXPLORATEUR D\'ÂGE COSMIQUE';

  @override
  String get splashDescription =>
      'Découvrez votre âge à travers\nl\'espace et le temps';

  @override
  String get beginExploration => 'COMMENCER L\'EXPLORATION  ↗';

  @override
  String get privacyNote => 'Aucune donnée ne quitte votre appareil';

  @override
  String get language => 'Langue';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsSubtitle => 'Langue, thème et préférences';

  @override
  String get theme => 'Thème';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get navCalc => 'Calc';

  @override
  String get navPlanets => 'Planètes';

  @override
  String get navCompare => 'Comparer';

  @override
  String get navMembers => 'Membres';

  @override
  String get navSettings => 'Paramètres';
}
