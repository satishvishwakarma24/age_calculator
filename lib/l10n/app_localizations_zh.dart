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
  String get navBirthdays => 'Birthdays';

  @override
  String get navSettings => '设置';

  @override
  String get tabYourAge => 'Your age';

  @override
  String get tabBirthdays => 'Birthdays';

  @override
  String get tabPlanets => 'Age on other planets';

  @override
  String get tabSettings => 'Settings';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get ageOnOptional => 'Age on (optional)';

  @override
  String get clearAgeOn => 'Clear Age on';

  @override
  String get calculateAge => 'Calculate age';

  @override
  String get years => 'years';

  @override
  String get months => 'months';

  @override
  String get days => 'days';

  @override
  String hoursLived(String days, String weeks, String hours) {
    return '$days days · $weeks weeks · $hours hours lived';
  }

  @override
  String get daysToNextBirthday => 'days to your\nnext birthday';

  @override
  String turningAge(int age, String date) {
    return 'Turning $age on $date';
  }

  @override
  String get saveToBirthdays => 'Save to birthdays';

  @override
  String get searchBirthdays => 'Search by name or group';

  @override
  String get addBirthday => 'Add birthday';

  @override
  String get noBirthdaysFound => 'No birthdays found.';

  @override
  String daysLabel(int n) {
    return '$n days';
  }

  @override
  String get deleteBirthday => 'Delete birthday?';

  @override
  String deleteBirthdayConfirm(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get addBirthdayTitle => 'Add birthday';

  @override
  String get editBirthdayTitle => 'Edit birthday';

  @override
  String get namePlaceholder => 'Name';

  @override
  String get selectDate => 'Select date';

  @override
  String get groupPlaceholder => 'Group';

  @override
  String get save => 'Save';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get calculateFirst => 'Calculate your age first.';

  @override
  String get yourAgeOnPlanet => 'Your age on this planet';

  @override
  String get close => 'Close';

  @override
  String get diameter => 'Diameter';

  @override
  String get mass => 'Mass';

  @override
  String get distanceFromSun => 'Distance from Sun';

  @override
  String get averageTemp => 'Average Temp';

  @override
  String get orbitalPeriod => 'Orbital Period';

  @override
  String earthYears(String n) {
    return '$n Earth years';
  }

  @override
  String get dateFormat => 'Date format';

  @override
  String get deleteAllData => 'Delete all saved data';

  @override
  String get deleteAllConfirmTitle => 'Delete all saved data?';

  @override
  String get deleteAllConfirmBody =>
      'This action is permanent. All your calculated ages, birthdays, and preferences will be wiped.';

  @override
  String get deleteAll => 'Delete all';

  @override
  String get privacyFooter =>
      'Everything stays on this device.\nPlanet ages are approximate.';
}
