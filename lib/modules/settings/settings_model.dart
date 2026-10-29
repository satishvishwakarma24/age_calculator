/// Theme options offered in Settings: `(value, label)`.
const List<(String, String)> themeOptions = [
  ('system', 'System default'),
  ('dark', 'Dark'),
  ('light', 'Light'),
];

/// Date format options offered in Settings: `(value, sample)`.
const List<(String, String)> dateFormatOptions = [
  ('ddmmyy', 'DD/MM/YY'),
  ('mdy', 'MM/DD/YYYY'),
  ('iso', 'YYYY-MM-DD'),
  ('long', 'DD MMM YYYY'),
];

/// User preferences persisted by the settings module.
class AppSettings {
  /// One of `system`, `dark`, `light`.
  final String theme;

  /// One of `dmy`, `mdy`, `iso`, `long`.
  final String format;

  const AppSettings({this.theme = 'system', this.format = 'ddmmyy'});

  AppSettings copyWith({String? theme, String? format}) =>
      AppSettings(theme: theme ?? this.theme, format: format ?? this.format);
}
