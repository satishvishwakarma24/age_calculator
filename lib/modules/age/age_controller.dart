import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/date_utils.dart';
import 'age_model.dart';

/// Owns the date-of-birth state for the Age tab and persists it.
class AgeController extends ChangeNotifier {
  static const String dobKey = 'dob';

  DateTime? _dob;
  DateTime? _asOf;
  String? _error;
  bool _showResult = false;

  DateTime? get dob => _dob;
  DateTime? get asOf => _asOf;
  String? get error => _error;
  bool get showResult => _showResult;

  /// The date the age is computed for.
  DateTime get effectiveDate => _asOf ?? now;

  bool get hasResult =>
      _showResult && _dob != null && effectiveDate.isAfter(_dob!);

  AgeResult? get result => hasResult ? AgeResult.of(_dob!, effectiveDate) : null;

  UpcomingBirthday? get upcoming => hasResult ? UpcomingBirthday.of(_dob!) : null;

  AgeController() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    var stored = parseIsoDate(prefs.getString(dobKey));
    if (validateDob(stored) != null) stored = null;
    _dob = stored;
    _showResult = stored != null;
    notifyListeners();
  }

  Future<void> _saveDob() async {
    final prefs = await SharedPreferences.getInstance();
    if (_dob == null) {
      await prefs.remove(dobKey);
    } else {
      await prefs.setString(dobKey, formatIso(_dob!));
    }
  }

  void setDob(DateTime d) {
    _dob = d;
    _showResult = false;
    _error = null;
    notifyListeners();
  }

  void setAsOf(DateTime d) {
    _asOf = d;
    _showResult = false;
    notifyListeners();
  }

  void clearAsOf() {
    _asOf = null;
    _error = null;
    _showResult = false;
    notifyListeners();
  }

  Future<void> calculate() async {
    _error = validateDob(_dob);
    if (_error == null && _asOf != null && !_asOf!.isAfter(_dob!)) {
      _error = 'Age on must be after date of birth';
    }
    _showResult = _error == null;
    notifyListeners();
    if (_showResult) await _saveDob();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(dobKey);
    _dob = null;
    _asOf = null;
    _error = null;
    _showResult = false;
    notifyListeners();
  }
}
