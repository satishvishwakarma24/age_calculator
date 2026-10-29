import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Age Calc'**
  String get appTitle;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'COSMIC AGE EXPLORER'**
  String get splashTagline;

  /// No description provided for @splashDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover your age across\nspace and time'**
  String get splashDescription;

  /// No description provided for @beginExploration.
  ///
  /// In en, this message translates to:
  /// **'BEGIN EXPLORATION  ↗'**
  String get beginExploration;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'No data leaves your device'**
  String get privacyNote;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language, theme & preferences'**
  String get settingsSubtitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @navCalc.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get navCalc;

  /// No description provided for @navPlanets.
  ///
  /// In en, this message translates to:
  /// **'Planets'**
  String get navPlanets;

  /// No description provided for @navBirthdays.
  ///
  /// In en, this message translates to:
  /// **'Birthdays'**
  String get navBirthdays;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @tabYourAge.
  ///
  /// In en, this message translates to:
  /// **'Your age'**
  String get tabYourAge;

  /// No description provided for @tabBirthdays.
  ///
  /// In en, this message translates to:
  /// **'Birthdays'**
  String get tabBirthdays;

  /// No description provided for @tabPlanets.
  ///
  /// In en, this message translates to:
  /// **'Age on other planets'**
  String get tabPlanets;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @ageOnOptional.
  ///
  /// In en, this message translates to:
  /// **'Age on (optional)'**
  String get ageOnOptional;

  /// No description provided for @clearAgeOn.
  ///
  /// In en, this message translates to:
  /// **'Clear Age on'**
  String get clearAgeOn;

  /// No description provided for @calculateAge.
  ///
  /// In en, this message translates to:
  /// **'Calculate age'**
  String get calculateAge;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @hoursLived.
  ///
  /// In en, this message translates to:
  /// **'{days} days · {weeks} weeks · {hours} hours lived'**
  String hoursLived(String days, String weeks, String hours);

  /// No description provided for @daysToNextBirthday.
  ///
  /// In en, this message translates to:
  /// **'days to your\nnext birthday'**
  String get daysToNextBirthday;

  /// No description provided for @turningAge.
  ///
  /// In en, this message translates to:
  /// **'Turning {age} on {date}'**
  String turningAge(int age, String date);

  /// No description provided for @saveToBirthdays.
  ///
  /// In en, this message translates to:
  /// **'Save to birthdays'**
  String get saveToBirthdays;

  /// No description provided for @searchBirthdays.
  ///
  /// In en, this message translates to:
  /// **'Search by name or group'**
  String get searchBirthdays;

  /// No description provided for @addBirthday.
  ///
  /// In en, this message translates to:
  /// **'Add birthday'**
  String get addBirthday;

  /// No description provided for @noBirthdaysFound.
  ///
  /// In en, this message translates to:
  /// **'No birthdays found.'**
  String get noBirthdaysFound;

  /// No description provided for @daysLabel.
  ///
  /// In en, this message translates to:
  /// **'{n} days'**
  String daysLabel(int n);

  /// No description provided for @deleteBirthday.
  ///
  /// In en, this message translates to:
  /// **'Delete birthday?'**
  String get deleteBirthday;

  /// No description provided for @deleteBirthdayConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String deleteBirthdayConfirm(String name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addBirthdayTitle.
  ///
  /// In en, this message translates to:
  /// **'Add birthday'**
  String get addBirthdayTitle;

  /// No description provided for @editBirthdayTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit birthday'**
  String get editBirthdayTitle;

  /// No description provided for @namePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get namePlaceholder;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @groupPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get groupPlaceholder;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @calculateFirst.
  ///
  /// In en, this message translates to:
  /// **'Calculate your age first.'**
  String get calculateFirst;

  /// No description provided for @yourAgeOnPlanet.
  ///
  /// In en, this message translates to:
  /// **'Your age on this planet'**
  String get yourAgeOnPlanet;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @diameter.
  ///
  /// In en, this message translates to:
  /// **'Diameter'**
  String get diameter;

  /// No description provided for @mass.
  ///
  /// In en, this message translates to:
  /// **'Mass'**
  String get mass;

  /// No description provided for @distanceFromSun.
  ///
  /// In en, this message translates to:
  /// **'Distance from Sun'**
  String get distanceFromSun;

  /// No description provided for @averageTemp.
  ///
  /// In en, this message translates to:
  /// **'Average Temp'**
  String get averageTemp;

  /// No description provided for @orbitalPeriod.
  ///
  /// In en, this message translates to:
  /// **'Orbital Period'**
  String get orbitalPeriod;

  /// No description provided for @earthYears.
  ///
  /// In en, this message translates to:
  /// **'{n} Earth years'**
  String earthYears(String n);

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get dateFormat;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved data'**
  String get deleteAllData;

  /// No description provided for @deleteAllConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved data?'**
  String get deleteAllConfirmTitle;

  /// No description provided for @deleteAllConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent. All your calculated ages, birthdays, and preferences will be wiped.'**
  String get deleteAllConfirmBody;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAll;

  /// No description provided for @privacyFooter.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this device.\nPlanet ages are approximate.'**
  String get privacyFooter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ja',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
