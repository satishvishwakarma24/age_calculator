// Shared, dependency-free date and age math.
// Used by the age, birthday and planets feature modules.

/// Normalises [d] to a UTC midnight date so only the calendar day matters.
DateTime dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

/// Today's calendar date (UTC midnight).
DateTime get now => dateOnly(DateTime.now());

/// Whole days from [a] to [b].
int daysBetween(DateTime a, DateTime b) =>
    dateOnly(b).difference(dateOnly(a)).inDays;

/// Number of days in the given month.
int daysInMonth(int y, int m) => DateTime.utc(y, m + 1, 0).day;

/// [d] shifted by [n] months, clamping the day to the target month.
DateTime addMonths(DateTime d, int n) {
  final x = d.month - 1 + n, y = d.year + x ~/ 12, m = x % 12 + 1;
  return DateTime.utc(y, m, d.day.clamp(1, daysInMonth(y, m)));
}

/// Age of [b] on [t] as `[years, months, days]`.
List<int> ageBreakdown(DateTime b, DateTime t) {
  var m = (t.year - b.year) * 12 + t.month - b.month;
  if (addMonths(b, m).isAfter(t)) m--;
  return [m ~/ 12, m % 12, daysBetween(addMonths(b, m), t)];
}

/// [b]'s birthday in year [y] (day clamped to the month length).
DateTime birthdayInYear(DateTime b, int y) =>
    DateTime.utc(y, b.month, b.day.clamp(1, daysInMonth(y, b.month)));

/// The next birthday of [b] from today.
DateTime nextBirthday(DateTime b) {
  final d = birthdayInYear(b, now.year);
  return d.isBefore(now) ? birthdayInYear(b, now.year + 1) : d;
}

/// `yyyy-MM-dd`.
String formatIso(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Parses a `yyyy-MM-dd` string, returning null when invalid.
DateTime? parseIsoDate(String? s) {
  if (s == null || !RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(s)) return null;
  final parts = s.split('-');
  return DateTime.tryParse('${parts[0]}-${parts[1]}-${parts[2]}');
}

/// Validation message for a date of birth, or null when valid.
String? validateDob(DateTime? d) {
  if (d == null) return 'Date of birth is required';
  if (d.year < 1900) return 'Minimum year is 1900';
  if (d.isAfter(now)) return 'Future birth dates are not allowed';
  return null;
}

const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// Formats [d] according to [format] (`dmy`, `mdy`, `iso` or `long`).
String formatDate(DateTime d, String format) {
  final day = d.day.toString().padLeft(2, '0');
  final month = d.month.toString().padLeft(2, '0');
  switch (format) {
    case 'iso':
      return formatIso(d);
    case 'mdy':
      return '$month/$day/${d.year}';
    case 'long':
      return '${d.day} ${_monthNames[d.month - 1]} ${d.year}';
    default:
      return '$day/$month/${d.year}';
  }
}
