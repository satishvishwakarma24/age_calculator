// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Age Calc';

  @override
  String get splashTagline => 'EXPLORADOR CÓSMICO DE EDAD';

  @override
  String get splashDescription =>
      'Descubre tu edad a través\ndel espacio y el tiempo';

  @override
  String get beginExploration => 'COMENZAR EXPLORACIÓN  ↗';

  @override
  String get privacyNote => 'Ningún dato sale de tu dispositivo';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Ajustes';

  @override
  String get settingsSubtitle => 'Idioma, tema y preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get navCalc => 'Edad';

  @override
  String get navPlanets => 'Planetas';

  @override
  String get navBirthdays => 'Cumpleaños';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get tabYourAge => 'Tu edad';

  @override
  String get tabBirthdays => 'Cumpleaños';

  @override
  String get tabPlanets => 'Edad en otros planetas';

  @override
  String get tabSettings => 'Ajustes';

  @override
  String get dateOfBirth => 'Fecha de nacimiento';

  @override
  String get ageOnOptional => 'Edad en (opcional)';

  @override
  String get clearAgeOn => 'Borrar fecha';

  @override
  String get calculateAge => 'Calcular edad';

  @override
  String get years => 'años';

  @override
  String get months => 'meses';

  @override
  String get days => 'días';

  @override
  String hoursLived(String days, String weeks, String hours) {
    return '$days días · $weeks semanas · $hours horas vividas';
  }

  @override
  String get daysToNextBirthday => 'días para tu\npróximo cumpleaños';

  @override
  String turningAge(int age, String date) {
    return 'Cumpliendo $age el $date';
  }

  @override
  String get saveToBirthdays => 'Guardar en cumpleaños';

  @override
  String get searchBirthdays => 'Buscar por nombre o grupo';

  @override
  String get addBirthday => 'Añadir cumpleaños';

  @override
  String get noBirthdaysFound => 'No se encontraron cumpleaños.';

  @override
  String daysLabel(int n) {
    return '$n días';
  }

  @override
  String get deleteBirthday => '¿Eliminar cumpleaños?';

  @override
  String deleteBirthdayConfirm(String name) {
    return '¿Estás seguro de eliminar a $name?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get addBirthdayTitle => 'Añadir cumpleaños';

  @override
  String get editBirthdayTitle => 'Editar cumpleaños';

  @override
  String get namePlaceholder => 'Nombre';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get groupPlaceholder => 'Grupo';

  @override
  String get save => 'Guardar';

  @override
  String get nameRequired => 'El nombre es obligatorio';

  @override
  String get calculateFirst => 'Calcula tu edad primero.';

  @override
  String get yourAgeOnPlanet => 'Tu edad en este planeta';

  @override
  String get close => 'Cerrar';

  @override
  String get diameter => 'Diámetro';

  @override
  String get mass => 'Masa';

  @override
  String get distanceFromSun => 'Distancia del Sol';

  @override
  String get averageTemp => 'Temp. media';

  @override
  String get orbitalPeriod => 'Período orbital';

  @override
  String earthYears(String n) {
    return '$n años terrestres';
  }

  @override
  String get dateFormat => 'Formato de fecha';

  @override
  String get deleteAllData => 'Eliminar todos los datos';

  @override
  String get deleteAllConfirmTitle => '¿Eliminar todos los datos?';

  @override
  String get deleteAllConfirmBody =>
      'Esta acción es permanente. Se borrarán todas tus edades, cumpleaños y preferencias.';

  @override
  String get deleteAll => 'Eliminar todo';

  @override
  String get privacyFooter =>
      'Todo permanece en este dispositivo.\nLas edades planetarias son aproximadas.';
}
