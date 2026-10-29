// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'مستكشف العمر الكوني';

  @override
  String get splashDescription => 'اكتشف عمرك عبر\nالفضاء والزمن';

  @override
  String get beginExploration => 'ابدأ الاستكشاف  ↗';

  @override
  String get privacyNote => 'لا تغادر بياناتك جهازك';

  @override
  String get language => 'اللغة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get settingsSubtitle => 'اللغة والمظهر والتفضيلات';

  @override
  String get theme => 'المظهر';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get navCalc => 'حساب';

  @override
  String get navPlanets => 'كواكب';

  @override
  String get navBirthdays => 'Birthdays';

  @override
  String get navSettings => 'إعدادات';

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
