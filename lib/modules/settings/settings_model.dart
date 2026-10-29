/// Theme options offered in Settings: `(value, label)`.
const List<(String, String)> themeOptions = [
  ('system', 'Match device'),
  ('dark', 'Dark'),
  ('light', 'Light'),
];

/// Date format options offered in Settings: `(value, sample)`.
const List<(String, String)> dateFormatOptions = [
  ('dmy', '31/12/2000'),
  ('mdy', '12/31/2000'),
  ('iso', '2000-12-31'),
  ('long', '31 Dec 2000'),
];

/// User preferences persisted by the settings module.
class AppSettings {
  /// One of `system`, `dark`, `light`.
  final String theme;

  /// One of `dmy`, `mdy`, `iso`, `long`.
  final String format;

  const AppSettings({this.theme = 'system', this.format = 'dmy'});

  AppSettings copyWith({String? theme, String? format}) =>
      AppSettings(theme: theme ?? this.theme, format: format ?? this.format);
}
