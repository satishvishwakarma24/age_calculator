# Age Calculator

A cosmic-themed Flutter app for exploring age in multiple ways. The current build opens with a splash screen and then a four-tab home experience focused on age calculation, date comparison, planetary age equivalents, and member profiles.

## What the app includes

- Splash screen with animated logo and call to action
- Age calculator screen with date-of-birth entry and age summary cards
- Date comparison screen for measuring the difference between two dates
- Solar system screen that shows age equivalents across planets
- Members screen for saved profiles and upcoming birthdays
- Custom cosmic UI, dark palette, and persistent bottom navigation

## Tech Stack

- Flutter and Dart
- Material design with custom theme primitives
- Native splash screen configuration
- App icon and launcher icon setup
- Localization support scaffolding via `flutter_localizations` and `intl`

## Project Structure

```text
lib/
├── main.dart              # App entry point and startup setup
├── app.dart               # MaterialApp bootstrap and screen routing
├── core/
│   ├── l10n/              # Generated localization files and ARB sources
│   ├── theme/             # App colors, gradients, spacing, typography
│   └── utils/             # Shared helpers and app-level utilities
├── views/
│   ├── splash_view.dart
│   ├── home_view.dart
│   ├── calculator_view.dart
│   ├── compare_view.dart
│   ├── solar_system_view.dart
│   └── members_view.dart
└── widgets/
    ├── common/
    ├── calculator/
    ├── compare/
    ├── members/
    └── solar/
```

## Getting Started

1. Install dependencies.

```bash
flutter pub get
```

2. Run the app.

```bash
flutter run
```

3. If you change localization files, regenerate them.

```bash
flutter gen-l10n
```

## Notes

- The current implementation is mostly local and UI-driven.
- Several screens still use placeholder data and are marked in code for future controller-backed logic.
- The app is configured for portrait mode and uses a transparent status bar for the space-style layout.

## Customization

- Update app icons in `assets/images/` and regenerate launcher assets.
- Adjust splash settings in `pubspec.yaml` under `flutter_native_splash`.
- Change the visible app name in `lib/app.dart` if needed.

## Build Targets

The project is set up for Android and iOS, with native splash and launcher icon configuration already included.