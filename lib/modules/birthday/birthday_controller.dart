import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'birthday_model.dart';

/// Owns the saved birthday list and persists it.
class BirthdayController extends ChangeNotifier {
  static const String peopleKey = 'people';

  final List<Person> _people = [];
  String _search = '';

  List<Person> get people => List.unmodifiable(_people);

  String get search => _search;

  /// People matching the current search, ordered by nearest birthday.
  List<Person> get visible {
    final query = _search.toLowerCase();
    return _people
        .where((p) => '${p.name} ${p.group}'.toLowerCase().contains(query))
        .toList()
      ..sort((a, b) => a.daysUntilNext.compareTo(b.daysUntilNext));
  }

  BirthdayController() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(peopleKey) ?? '[]';
    _people
      ..clear()
      ..addAll(_decode(raw));
    notifyListeners();
  }

  List<Person> _decode(String raw) {
    try {
      return (jsonDecode(raw) as List)
          .map((x) => Person.fromMap(Map<String, String>.from(x as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      peopleKey,
      jsonEncode(_people.map((p) => p.toMap()).toList()),
    );
  }

  void setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> add(Person person) async {
    _people.add(person);
    notifyListeners();
    await _save();
  }

  Future<void> update(String id, Person person) async {
    final index = _people.indexWhere((p) => p.id == id);
    if (index == -1) return;
    _people[index] = person;
    notifyListeners();
    await _save();
  }

  Future<void> remove(String id) async {
    _people.removeWhere((p) => p.id == id);
    notifyListeners();
    await _save();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(peopleKey);
    _people.clear();
    _search = '';
    notifyListeners();
  }
}
