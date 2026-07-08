# Flutter Travel

[Leia em português](./README.pt-BR.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE) ![Free](https://img.shields.io/badge/price-free-brightgreen)

Flutter Travel is a free travel and booking UI template built with Flutter 3.44 and Material 3. It has 8 screens with light and dark themes, covering the trip flow from discovery to voucher: an explore screen with destinations and experiences, a destination page, a hotel list with price and star filters, a hotel page with amenities and a map drawn in CustomPaint, a booking form with dates and guests, a voucher with a QR code, a trips list, and a profile with loyalty status. Navigation combines a 4-tab shell with pushed go_router routes. All data is local mock data, so the app runs with no backend, and the http service stubs mark where a real API would plug in. It is part of the free tier of the [template.dev.br](https://template.dev.br) catalog.

## Screens

8 screens:

- Explore (`explore_screen.dart`): popular destinations, experiences and prices.
- Destination (`destination_detail_screen.dart`): destination page with highlights.
- Hotels (`hotels_screen.dart`): hotel list with price and star filters.
- Hotel (`hotel_detail_screen.dart`): amenities, reviews and a location map drawn in CustomPaint.
- Booking (`booking_screen.dart`): reservation form with dates and guest count.
- Voucher (`voucher_screen.dart`): booking confirmation with a QR code.
- Trips (`trips_screen.dart`): upcoming and past trips.
- Profile (`profile_screen.dart`): user data and loyalty program status.

### Screenshots

The `screenshots/` folder has 16 captures. A sample:

![Explore](screenshots/travel.png)
![Destination](screenshots/travel-2.png)
![Hotels](screenshots/travel-3.png)
![Hotel](screenshots/travel-4.png)
![Booking](screenshots/travel-5.png)
![Voucher](screenshots/travel-6.png)

## Tech stack

- Flutter 3.44, stable channel (pinned through FVM in `.fvmrc`)
- Dart SDK `^3.12.2`
- Material 3 (`useMaterial3: true`, `ColorScheme.fromSeed`)
- go_router `^17.3.0`: declarative routing
- provider `^6.1.5+1`: state management (MVVM view models)
- http `^1.6.0`: API service layer
- intl `^0.20.3`: date and currency formatting (pt_BR date symbols loaded at startup)
- cupertino_icons `^1.0.8`
- flutter_lints `^6.0.0` (dev)

Exact resolved versions are in `pubspec.lock`. Target platforms included in the repo: Android, iOS, web and Windows.

## Requirements

- Flutter SDK, stable channel. The lockfile requires Flutter 3.38 or newer; the template was built against 3.44.
- Dart 3.12.2 or newer (bundled with the Flutter SDK).
- Platform tooling for your target: Android Studio and the Android SDK, Xcode for iOS, Chrome for web, or Visual Studio with the C++ workload for Windows.
- Optional: [FVM](https://fvm.app). The repo has a `.fvmrc` pinning the stable channel, so `fvm use` selects a matching SDK.

## How to run

```bash
flutter pub get
flutter run
```

Pick a device with `flutter run -d chrome` (web), `flutter run -d windows`, or a device id from `flutter devices`.

Release builds:

```bash
flutter build apk       # Android
flutter build ipa       # iOS (requires macOS and Xcode)
flutter build web       # Web
flutter build windows   # Windows
```

With FVM, prefix the commands: `fvm flutter pub get`, `fvm flutter run`. Run the widget tests with `flutter test`.

## Project structure

```
lib/
  main.dart              # entry point, loads pt_BR date symbols (intl)
  app.dart               # MaterialApp.router, light/dark theme wiring
  core/
    router.dart          # go_router route table
    theme.dart           # Material 3 theme (seed color, component themes)
  data/
    models/              # API models with fromJson/toJson
    repositories/        # destination, hotel, booking, trip, profile (mock data)
    services/            # http-based API service stubs
  domain/
    models/              # Destination, Hotel, Review, Booking, Trip, UserProfile
  ui/
    core/widgets/        # shared widgets
    features/<feature>/  # views/ (screens) and view_models/ per feature
```

## Theming and customization

The theme lives in `lib/core/theme.dart`. Light and dark schemes are generated from a single seed color:

```dart
static const Color seed = Color(0xFF0E7490); // cyan/teal
```

Change `seed` to re-skin the app: `ColorScheme.fromSeed` derives every surface and accent color for both brightnesses. The font family is Roboto, set in the same file, along with component themes for the app bar, filled buttons and inputs (filled text fields, rounded corners, flat elevation). `app.dart` passes `AppTheme.light()` and `AppTheme.dark()` to `MaterialApp.router`, so the app follows the system theme mode.

Dates are formatted with `intl` in the pt_BR locale; `main.dart` calls `initializeDateFormatting('pt_BR', null)` before `runApp`. To change the locale, update that call and the `DateFormat` locales in the views.

## State management

MVVM with provider. Each screen has a `ChangeNotifier` view model under `lib/ui/features/<feature>/view_models/`, created with `ChangeNotifierProvider` in the route definitions in `lib/core/router.dart`. View models read from the repositories in `lib/data/repositories/`, which return mock data through the API-shaped services in `lib/data/services/`.

## Support this project

This template is free and MIT licensed. Donations keep the free templates maintained and updated to new Flutter releases: https://template.dev.br/doar?template=flutter-travel

## More templates

The full catalog, free and premium, is at https://template.dev.br.

## License

[MIT](./LICENSE), © 2026 Danilo Quinelato.
