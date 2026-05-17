/// Persisted member profile (stored in SharedPreferences).
class Member {
  final String id;
  final String name;
  final String avatar;
  final DateTime birthDate;
  final bool isPinned;

  const Member({
    required this.id,
    required this.name,
    required this.avatar,
    required this.birthDate,
    this.isPinned = false,
  });

  Member copyWith({
    String? name,
    String? avatar,
    DateTime? birthDate,
    bool? isPinned,
  }) {
    return Member(
      id: id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      birthDate: birthDate ?? this.birthDate,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'birthDate': _dateKey(birthDate),
        'isPinned': isPinned,
      };

  factory Member.fromJson(Map<String, dynamic> json) {
    final dateStr = json['birthDate'] as String;
    final parts = dateStr.split('-');
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '👤',
      birthDate: DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      ),
      isPinned: json['isPinned'] as bool? ?? false,
    );
  }

  static String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
