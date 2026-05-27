# Age Calculator (Flutter)

A production-style, cosmic-themed age utility app built with Flutter.  
It combines practical age tools (age breakdown, birthday countdown, member profiles) with astronomy-inspired visualization (planetary age equivalents), plus localization, theming, and ad integration.

## Why This Project Stands Out

- Clear feature modularization across routing, providers, views, and reusable widgets.
- Local-first persistence using `SharedPreferences` for DOB and member profiles.
- Multi-language support with generated localizations (`flutter gen-l10n`).
- Freezed-based immutable data models for safer state updates.
- Ad integration with Banner, Interstitial, Rewarded, and App Open support.

## Feature Set

- **Calculator**: age in years/months/days + totals + next birthday + zodiac.
- **Solar System View**: converts Earth age to planetary age equivalents.
- **Members**: add/edit/delete/pin members with upcoming birthday highlighting.
- **Settings**: theme mode toggle + runtime locale switching.
- **Splash + Navigation Shell**: animated route transitions and state-preserving tabs.

## App Screenshots

<p align="center">
  <img src="assets/screenshots/calculator_home_screen.png" alt="Calculator home screen" width="240" />
  <img src="assets/screenshots/solar_planets.png" alt="Solar planets screen" width="240" />
  <img src="assets/screenshots/members.png" alt="Members screen" width="240" />
  <img src="assets/screenshots/settings.png" alt="Settings screen" width="240" />
</p>

## Architecture Overview

The active app structure is centered around `config`, `core`, and `src`:

```text
lib/
├── main.dart                      # App bootstrap, providers, orientation/system UI, ads init
├── app.dart                       # MaterialApp wiring, theming, localization, router integration
├── config/
│   ├── routes/                    # Route names, validation, transition + route mapping
│   └── services/                  # Ads service (Banner/Interstitial/Rewarded/AppOpen)
├── core/
│   ├── const.dart                 # Animation timings and app-level constants
│   ├── theme/                     # Design system (colors, gradients, typography, theme provider)
│   ├── utils/                     # Locale provider and shared runtime helpers
│   └── widgets/                   # Ad widgets and app-open wrapper
├── src/
│   ├── enum/                      # Pure age/planet/zodiac calculation logic
│   ├── models/                    # Freezed models + generated code
│   ├── provider/                  # ChangeNotifier state managers
│   └── views/                     # Screens + screen-scoped widgets
└── l10n/                          # Generated localization output
```

## State Management and Data Flow

- Uses `provider` + `ChangeNotifier`.
- `AgeCalculatorProvider`
  - Handles DOB selection, calculation lifecycle, and persisted DOB restore.
  - Exposes `AgeResult` and derived planet ages to UI.
- `MembersProvider`
  - Handles CRUD, pinning, sorting, and birthday window filtering.
  - Persists member list as JSON in `SharedPreferences`.
- Models (`Member`, `MemberData`) use `freezed` for immutability/equality/copy semantics.

## Routing and Navigation

- Named routes centralized in `config/routes/routes_name.dart`.
- `AppRouter` validates routes and resolves unknown routes safely.
- Route transitions use `SharedAxisTransition` for consistent motion.
- Main UX runs in `HomeView` via `IndexedStack` to preserve tab state.

## Tech Stack

- Flutter (Material 3 style usage with custom design language)
- Provider (state management)
- Freezed + Json Serializable (immutable models + serialization)
- Shared Preferences (local persistence)
- Intl + Flutter Localizations (multi-language support)
- Google Mobile Ads (monetization modules)

## Localization

- Enabled via `flutter.generate: true`.
- Backed by generated `AppLocalizations`.
- Current supported language set is defined in `LocaleProvider`.

## Setup

### Prerequisites

- Flutter SDK (stable channel)
- Dart SDK (matching Flutter)
- Android Studio / Xcode for platform builds

### Install and Run

```bash
flutter pub get
flutter run
```

### Generate Code (after model changes)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Regenerate Localization (after ARB changes)

```bash
flutter gen-l10n
```

## Build and Assets

- Native splash config is in `pubspec.yaml` (`flutter_native_splash`).
- Launcher icon config is in `pubspec.yaml` (`flutter_launcher_icons`).
- Screenshots used in this README are under `assets/screenshots/`.

## Interviewer Notes

- This codebase demonstrates separation of concerns between UI, domain calculations, and app services.
- The app is intentionally local-first and offline-friendly.
- There are legacy/duplicate directories from earlier iterations (`lib/modules`, `lib/src/widgets`, `lib/src/utils`), while active implementations currently reside in `lib/src/views`, `lib/src/provider`, and `lib/src/enum`.

## Current Platform Scope

- Android and iOS supported.
- Portrait orientation enforced for a focused mobile experience.