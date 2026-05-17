// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'コスミック年齢エクスプローラー';

  @override
  String get splashDescription => '宇宙と時間を越えて\nあなたの年齢を発見';

  @override
  String get beginExploration => '探索を始める  ↗';

  @override
  String get privacyNote => 'データはデバイスから送信されません';

  @override
  String get language => '言語';

  @override
  String get settings => '設定';

  @override
  String get settingsSubtitle => '言語、テーマ、各種設定';

  @override
  String get theme => 'テーマ';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get navCalc => '計算';

  @override
  String get navPlanets => '惑星';

  @override
  String get navCompare => '比較';

  @override
  String get navMembers => 'メンバー';

  @override
  String get navSettings => '設定';
}
