// Pure age / planetary-age math — no Flutter dependencies.

/// Result of an age calculation from date of birth to a reference date.
class AgeResult {
  final int years;
  final int months;
  final int days;
  final int totalDays;
  final int totalMonths;
  final int totalHours;
  final DateTime nextBirthday;
  final int daysUntilBirthday;
  final String zodiacSign;

  const AgeResult({
    required this.years,
    required this.months,
    required this.days,
    required this.totalDays,
    required this.totalMonths,
    required this.totalHours,
    required this.nextBirthday,
    required this.daysUntilBirthday,
    required this.zodiacSign,
  });

  /// Earth age as fractional years (for planetary conversions).
  double get earthYears =>
      totalDays / _daysPerEarthYear;
}

/// One row in the planetary age list.
class PlanetAgeInfo {
  final String name;
  final String symbol;
  final String description;
  final double ageOnPlanet;
  const PlanetAgeInfo({
    required this.name,
    required this.symbol,
    required this.description,
    required this.ageOnPlanet,
  });
}

const double _daysPerEarthYear = 365.25;

/// Orbital period in Earth days → multiplier (planet years per Earth year).
const Map<String, ({String symbol, double earthYearsPerPlanetYear})>
    kPlanetOrbitRatios = {
  'Mercury': (symbol: '☿', earthYearsPerPlanetYear: 4.15),
  'Venus': (symbol: '♀', earthYearsPerPlanetYear: 1.62),
  'Mars': (symbol: '♂', earthYearsPerPlanetYear: 0.53),
  'Jupiter': (symbol: '♃', earthYearsPerPlanetYear: 0.084),
  'Saturn': (symbol: '♄', earthYearsPerPlanetYear: 0.034),
  'Uranus': (symbol: '⛢', earthYearsPerPlanetYear: 0.012),
  'Neptune': (symbol: '♆', earthYearsPerPlanetYear: 0.006),
};

/// Computes calendar age and totals from [birthDate] to [reference] (default: today).
AgeResult computeAge(
  DateTime birthDate, {
  DateTime? reference,
}) {
  final ref = _dateOnly(reference ?? DateTime.now());
  final birth = _dateOnly(birthDate);

  if (birth.isAfter(ref)) {
    throw ArgumentError('Date of birth cannot be in the future');
  }

  var years = ref.year - birth.year;
  var months = ref.month - birth.month;
  var days = ref.day - birth.day;

  if (days < 0) {
    months--;
    final prevMonth = DateTime(ref.year, ref.month, 0);
    days += prevMonth.day;
  }
  if (months < 0) {
    years--;
    months += 12;
  }

  final totalDays = ref.difference(birth).inDays;
  final totalMonths = years * 12 + months;
  final totalHours = totalDays * 24;

  var nextBirthday = DateTime(ref.year, birth.month, birth.day);
  if (!nextBirthday.isAfter(ref)) {
    nextBirthday = DateTime(ref.year + 1, birth.month, birth.day);
  }
  final daysUntilBirthday = nextBirthday.difference(ref).inDays;

  return AgeResult(
    years: years,
    months: months,
    days: days,
    totalDays: totalDays,
    totalMonths: totalMonths,
    totalHours: totalHours,
    nextBirthday: nextBirthday,
    daysUntilBirthday: daysUntilBirthday,
    zodiacSign: zodiacForDate(birth),
  );
}

List<PlanetAgeInfo> computePlanetAges(double earthYears) {
  return kPlanetOrbitRatios.entries.map((e) {
    final ratio = e.value.earthYearsPerPlanetYear;
    final age = earthYears * ratio;
    return PlanetAgeInfo(
      name: e.key,
      symbol: e.value.symbol,
      description:
          '1 Earth yr = ${ratio.toStringAsFixed(ratio < 0.1 ? 3 : 2)} ${e.key} yrs',
      ageOnPlanet: age,
    );
  }).toList();
}

String formatPlanetAge(double age) {
  if (age >= 100) return age.toStringAsFixed(1);
  if (age >= 10) return age.toStringAsFixed(1);
  if (age >= 1) return age.toStringAsFixed(1);
  return age.toStringAsFixed(1);
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Western zodiac for a calendar date.
String zodiacForDate(DateTime date) {
  final m = date.month;
  final d = date.day;
  if ((m == 3 && d >= 21) || (m == 4 && d <= 19)) return 'Aries ♈';
  if ((m == 4 && d >= 20) || (m == 5 && d <= 20)) return 'Taurus ♉';
  if ((m == 5 && d >= 21) || (m == 6 && d <= 20)) return 'Gemini ♊';
  if ((m == 6 && d >= 21) || (m == 7 && d <= 22)) return 'Cancer ♋';
  if ((m == 7 && d >= 23) || (m == 8 && d <= 22)) return 'Leo ♌';
  if ((m == 8 && d >= 23) || (m == 9 && d <= 22)) return 'Virgo ♍';
  if ((m == 9 && d >= 23) || (m == 10 && d <= 22)) return 'Libra ♎';
  if ((m == 10 && d >= 23) || (m == 11 && d <= 21)) return 'Scorpio ♏';
  if ((m == 11 && d >= 22) || (m == 12 && d <= 21)) return 'Sagittarius ♐';
  if ((m == 12 && d >= 22) || (m == 1 && d <= 19)) return 'Capricorn ♑';
  if ((m == 1 && d >= 20) || (m == 2 && d <= 18)) return 'Aquarius ♒';
  return 'Pisces ♓';
}
