import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
part 'member.g.dart';

/// Persisted member profile (stored in SharedPreferences).
@freezed
class Member with _$Member {
  const factory Member({
    required String id,
    required String name,
    @Default('👤') String avatar,
    @DateOnlyConverter() required DateTime birthDate,
    @Default(false) bool isPinned,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

class DateOnlyConverter implements JsonConverter<DateTime, Object?> {
  const DateOnlyConverter();

  @override
  DateTime fromJson(Object? value) {
    if (value is String) {
      final parts = value.split('-');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
    }
    if (value is DateTime) {
      return DateTime(value.year, value.month, value.day);
    }
    throw const FormatException('Invalid birthDate value');
  }

  @override
  Object toJson(DateTime date) => '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
