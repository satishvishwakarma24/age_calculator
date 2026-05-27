import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum/age_calculation.dart';

/// Shared DOB + calculated age across Calc and Planets tabs.
class AgeCalculatorProvider extends ChangeNotifier {
  static const _dobKey = 'date_of_birth_iso';
  static final _displayFormat = DateFormat('d MMM yyyy');
  static final _birthdayFormat = DateFormat('d MMM yyyy');

  DateTime _dateOfBirth = DateTime(2000, 1, 1);
  AgeResult? _result;
  bool _hasCalculated = false;
  bool _isCalculating = false;

  AgeCalculatorProvider() {
    _loadSavedDob();
  }

  DateTime get dateOfBirth => _dateOfBirth;
  String get formattedDob => _displayFormat.format(_dateOfBirth);
  AgeResult? get result => _result;
  bool get hasCalculated => _hasCalculated;
  bool get isCalculating => _isCalculating;

  List<PlanetAgeInfo> get planetAges {
    if (_result == null) return [];
    return computePlanetAges(_result!.earthYears);
  }

  Future<void> _loadSavedDob() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_dobKey);
    if (saved != null) {
      final parsed = DateTime.tryParse(saved);
      if (parsed != null) {
        _dateOfBirth = DateTime(parsed.year, parsed.month, parsed.day);
        _performCalculation();
        return;
      }
    }
    // Default preview values — calculate once on launch.
    _performCalculation();
  }

  Future<void> _saveDob() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _dobKey,
      _dateOfBirth.toIso8601String().split('T').first,
    );
  }

  /// Recalculates age from the current DOB to today (shows loading UI).
  Future<void> calculate() async {
    if (_isCalculating) return;

    _isCalculating = true;
    notifyListeners();

    // Let the spinner paint before running the calculation.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    _performCalculation();

    _isCalculating = false;
    notifyListeners();
  }

  void _performCalculation() {
    final today = DateTime.now();
    final birth = DateTime(
      _dateOfBirth.year,
      _dateOfBirth.month,
      _dateOfBirth.day,
    );
    if (birth.isAfter(_dateOnly(today))) {
      _result = null;
      _hasCalculated = false;
      return;
    }
    _result = computeAge(birth, reference: today);
    _hasCalculated = true;
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4FC3F7),
              onPrimary: Color(0xFF050A18),
              surface: Color(0xFF0D1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0D1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) return;
    _dateOfBirth = DateTime(picked.year, picked.month, picked.day);
    await _saveDob();
    await calculate();
  }

  String formatNextBirthday() {
    if (_result == null) return '—';
    return _birthdayFormat.format(_result!.nextBirthday);
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
