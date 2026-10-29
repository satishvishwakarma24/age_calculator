import '../../core/utils/date_utils.dart';

/// Computed age of a person as of a given date.
class AgeResult {
  final int years;
  final int months;
  final int days;
  final int totalDays;

  const AgeResult({
    required this.years,
    required this.months,
    required this.days,
    required this.totalDays,
  });

  factory AgeResult.of(DateTime dob, DateTime asOf) {
    final parts = ageBreakdown(dob, asOf);
    return AgeResult(
      years: parts[0],
      months: parts[1],
      days: parts[2],
      totalDays: daysBetween(dob, asOf),
    );
  }

  int get totalWeeks => totalDays ~/ 7;

  int get totalHours => totalDays * 24;
}

/// Info about the next birthday relative to today.
class UpcomingBirthday {
  final DateTime date;
  final int daysUntil;
  final int turningAge;

  const UpcomingBirthday({
    required this.date,
    required this.daysUntil,
    required this.turningAge,
  });

  factory UpcomingBirthday.of(DateTime dob) {
    final date = nextBirthday(dob);
    return UpcomingBirthday(
      date: date,
      daysUntil: daysBetween(now, date),
      turningAge: date.year - dob.year,
    );
  }
}
