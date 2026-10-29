// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'ब्रह्मांडीय आयु खोजक';

  @override
  String get splashDescription => 'अंतरिक्ष और समय में\nअपनी आयु जानें';

  @override
  String get beginExploration => 'खोज शुरू करें  ↗';

  @override
  String get privacyNote => 'कोई डेटा आपके डिवाइस से बाहर नहीं जाता';

  @override
  String get language => 'भाषा';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get settingsSubtitle => 'भाषा, थीम और प्राथमिकताएँ';

  @override
  String get theme => 'थीम';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get navCalc => 'आयु';

  @override
  String get navPlanets => 'ग्रह';

  @override
  String get navBirthdays => 'जन्मदिन';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get tabYourAge => 'आपकी आयु';

  @override
  String get tabBirthdays => 'जन्मदिन';

  @override
  String get tabPlanets => 'अन्य ग्रहों पर आयु';

  @override
  String get tabSettings => 'सेटिंग्स';

  @override
  String get dateOfBirth => 'जन्म तिथि';

  @override
  String get ageOnOptional => 'इस तारीख पर आयु (वैकल्पिक)';

  @override
  String get clearAgeOn => 'तारीख साफ़ करें';

  @override
  String get calculateAge => 'आयु गणना करें';

  @override
  String get years => 'वर्ष';

  @override
  String get months => 'महीने';

  @override
  String get days => 'दिन';

  @override
  String hoursLived(String days, String weeks, String hours) {
    return '$days दिन · $weeks सप्ताह · $hours घंटे जिए';
  }

  @override
  String get daysToNextBirthday => 'दिन आपके\nअगले जन्मदिन तक';

  @override
  String turningAge(int age, String date) {
    return '$date को $age वर्ष के होंगे';
  }

  @override
  String get saveToBirthdays => 'जन्मदिन में सहेजें';

  @override
  String get searchBirthdays => 'नाम या समूह से खोजें';

  @override
  String get addBirthday => 'जन्मदिन जोड़ें';

  @override
  String get noBirthdaysFound => 'कोई जन्मदिन नहीं मिला।';

  @override
  String daysLabel(int n) {
    return '$n दिन';
  }

  @override
  String get deleteBirthday => 'जन्मदिन हटाएं?';

  @override
  String deleteBirthdayConfirm(String name) {
    return 'क्या आप $name को हटाना चाहते हैं?';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get addBirthdayTitle => 'जन्मदिन जोड़ें';

  @override
  String get editBirthdayTitle => 'जन्मदिन संपादित करें';

  @override
  String get namePlaceholder => 'नाम';

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get groupPlaceholder => 'समूह';

  @override
  String get save => 'सहेजें';

  @override
  String get nameRequired => 'नाम आवश्यक है';

  @override
  String get calculateFirst => 'पहले अपनी आयु गणना करें।';

  @override
  String get yourAgeOnPlanet => 'इस ग्रह पर आपकी आयु';

  @override
  String get close => 'बंद करें';

  @override
  String get diameter => 'व्यास';

  @override
  String get mass => 'द्रव्यमान';

  @override
  String get distanceFromSun => 'सूर्य से दूरी';

  @override
  String get averageTemp => 'औसत तापमान';

  @override
  String get orbitalPeriod => 'कक्षीय अवधि';

  @override
  String earthYears(String n) {
    return '$n पृथ्वी वर्ष';
  }

  @override
  String get dateFormat => 'तारीख प्रारूप';

  @override
  String get deleteAllData => 'सभी सहेजा डेटा हटाएं';

  @override
  String get deleteAllConfirmTitle => 'सभी डेटा हटाएं?';

  @override
  String get deleteAllConfirmBody =>
      'यह क्रिया स्थायी है। आपकी सभी गणनाएं, जन्मदिन और प्राथमिकताएं मिटा दी जाएंगी।';

  @override
  String get deleteAll => 'सब हटाएं';

  @override
  String get privacyFooter =>
      'सब कुछ इस डिवाइस पर रहता है।\nग्रह आयु अनुमानित हैं।';
}
