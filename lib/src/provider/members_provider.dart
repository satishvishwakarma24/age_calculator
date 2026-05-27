import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/member.dart';
import '../models/member_display.dart';
import '../../core/theme/app_theme.dart';
import '../enum/age_calculation.dart';

/// Local member profiles — load/save via SharedPreferences.
class MembersProvider extends ChangeNotifier {
  static const _storageKey = 'members_profiles_v1';
  static const _upcomingWindowDays = 60;
  static final _dobFormat = DateFormat('d MMM yyyy');

  static const _accentPalette = [
    AppColors.tealAccent,
    AppColors.lavender,
    AppColors.amber,
    AppColors.starBlue,
    AppColors.mars,
    AppColors.jupiter,
  ];

  List<Member> _members = [];
  bool _isLoaded = false;

  MembersProvider() {
    _loadMembers();
  }

  bool get isLoaded => _isLoaded;
  int get count => _members.length;

  List<Member> get members => List.unmodifiable(_members);

  List<MemberData> get displayMembers {
    final sorted = [..._members]
      ..sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    return [
      for (var i = 0; i < sorted.length; i++)
        _toDisplay(sorted[i], i),
    ];
  }

  List<MemberData> get upcomingBirthdays => displayMembers
      .where((m) => m.birthdayIn != null)
      .toList()
    ..sort((a, b) {
      final daysA = _daysFromLabel(a.birthdayIn!);
      final daysB = _daysFromLabel(b.birthdayIn!);
      return daysA.compareTo(daysB);
    });

  Member? findById(String id) {
    try {
      return _members.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        _members = list
            .map((e) => Member.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        _members = [];
      }
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_members.map((m) => m.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
    notifyListeners();
  }

  Future<void> addMember({
    required String name,
    required DateTime birthDate,
    required String avatar,
  }) async {
    final member = Member(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
      avatar: avatar,
      birthDate: _dateOnly(birthDate),
    );
    _members.add(member);
    await _persist();
  }

  Future<void> updateMember({
    required String id,
    required String name,
    required DateTime birthDate,
    required String avatar,
  }) async {
    final index = _members.indexWhere((m) => m.id == id);
    if (index < 0) return;
    _members[index] = _members[index].copyWith(
      name: name.trim(),
      avatar: avatar,
      birthDate: _dateOnly(birthDate),
    );
    await _persist();
  }

  Future<void> deleteMember(String id) async {
    _members.removeWhere((m) => m.id == id);
    await _persist();
  }

  Future<void> togglePin(String id) async {
    final index = _members.indexWhere((m) => m.id == id);
    if (index < 0) return;
    _members[index] = _members[index].copyWith(
      isPinned: !_members[index].isPinned,
    );
    await _persist();
  }

  MemberData _toDisplay(Member member, int paletteIndex) {
    final birth = _dateOnly(member.birthDate);
    final today = _dateOnly(DateTime.now());

    String ageLabel;
    String? birthdayIn;

    if (birth.isAfter(today)) {
      ageLabel = '—';
    } else {
      final age = computeAge(birth, reference: today);
      ageLabel = '${age.years} yrs';
      if (age.daysUntilBirthday <= _upcomingWindowDays) {
        birthdayIn = age.daysUntilBirthday == 0
            ? 'today'
            : age.daysUntilBirthday == 1
                ? '1 day'
                : '${age.daysUntilBirthday} days';
      }
    }

    return MemberData(
      id: member.id,
      name: member.name,
      avatar: member.avatar,
      dobFormatted: _dobFormat.format(birth),
      ageLabel: ageLabel,
      accentColor: _accentPalette[paletteIndex % _accentPalette.length],
      isPinned: member.isPinned,
      birthdayIn: birthdayIn,
    );
  }

  int _daysFromLabel(String label) {
    if (label == 'today') return 0;
    if (label == '1 day') return 1;
    return int.tryParse(label.split(' ').first) ?? 999;
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
