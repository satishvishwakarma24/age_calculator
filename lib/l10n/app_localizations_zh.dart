// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => '宇宙年龄探索器';

  @override
  String get splashDescription => '在时空之中\n探索你的年龄';

  @override
  String get beginExploration => '开始探索  ↗';

  @override
  String get privacyNote => '数据不会离开您的设备';

  @override
  String get language => '语言';

  @override
  String get settings => '设置';

  @override
  String get settingsSubtitle => '语言、主题与偏好';

  @override
  String get theme => '主题';

  @override
  String get darkMode => '深色模式';

  @override
  String get navCalc => '计算';

  @override
  String get navPlanets => '行星';

  @override
  String get navCompare => '比较';

  @override
  String get navMembers => '成员';

  @override
  String get navSettings => '设置';
}
