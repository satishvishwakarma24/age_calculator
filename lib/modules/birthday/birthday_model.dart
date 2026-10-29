import '../../core/utils/date_utils.dart';

/// Groups offered when saving a birthday.
const List<String> birthdayGroups = ['Family', 'Friend', 'Work', 'Other'];

/// A saved person with a birthday.
class Person {
  final String id;
  final String name;
  final String group;
  final DateTime date;

  const Person({
    required this.id,
    required this.name,
    required this.group,
    required this.date,
  });

  factory Person.fromMap(Map<String, String> map) => Person(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        group: map['group'] ?? birthdayGroups.first,
        date: parseIsoDate(map['date']) ?? now,
      );

  Map<String, String> toMap() => {
        'id': id,
        'name': name,
        'date': formatIso(date),
        'group': group,
      };

  /// Days remaining until this person's next birthday.
  int get daysUntilNext => daysBetween(now, nextBirthday(date));

  /// Age this person will turn on their next birthday.
  int get turningAge => nextBirthday(date).year - date.year;

  /// Single uppercase letter used for the avatar.
  String get initial => name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';
}
