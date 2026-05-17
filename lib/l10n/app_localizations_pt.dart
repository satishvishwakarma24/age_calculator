// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'EXPLORADOR CÓSMICO DE IDADE';

  @override
  String get splashDescription =>
      'Descubra sua idade pelo\nespaço e pelo tempo';

  @override
  String get beginExploration => 'INICIAR EXPLORAÇÃO  ↗';

  @override
  String get privacyNote => 'Nenhum dado sai do seu dispositivo';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Configurações';

  @override
  String get settingsSubtitle => 'Idioma, tema e preferências';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get navCalc => 'Calc';

  @override
  String get navPlanets => 'Planetas';

  @override
  String get navCompare => 'Comparar';

  @override
  String get navMembers => 'Membros';

  @override
  String get navSettings => 'Config';
}
