# Veltrix Sports

**Coaching, events, and ticketing — Flutter application**

Veltrix Sports is a Flutter application project focused on bringing sports coaching, training plans, event discovery, and ticketing workflows into one mobile experience.

The repository is actively evolving. Refer to the implementation in `lib/` and the project documentation before assuming that every planned workflow is production-ready.

## Technology

The current `pubspec.yaml` defines the following core stack:

| Area | Current dependencies |
|---|---|
| Framework | Flutter |
| Language | Dart (`^3.11.5`) |
| State management | Riverpod (`flutter_riverpod`) |
| Navigation | GoRouter |
| Networking | Dio |
| Firebase | Firebase Core, Firebase Messaging |
| Local preferences and secure storage | Shared Preferences, Flutter Secure Storage |
| UI and visualisation | Flutter SVG, Lottie, Shimmer, FL Chart |
| Payments | Razorpay Flutter |
| Testing and linting | Flutter Test, Flutter Lints |

Dependency presence does not by itself mean that a corresponding integration is fully configured or enabled. Check the relevant feature implementation and platform configuration.

## Requirements

- Flutter SDK compatible with Dart 3.11.5
- Android Studio or Visual Studio Code
- Android SDK for Android development
- Platform-specific configuration for Firebase and payment integrations, where used

## Get started

```bash
git clone https://github.com/BezaleelPaul/veltrix-sports.git
cd veltrix-sports
flutter pub get
flutter analyze
flutter test
flutter run
```

If your local Flutter installation does not satisfy the Dart SDK constraint in `pubspec.yaml`, update or switch to a compatible Flutter SDK first.

## Repository documentation

The repository may include additional planning and engineering documents. Check the files present in the current branch for the latest versions of:

- Product roadmap and feature specifications
- API and database documentation
- Testing strategy
- Deployment guidance
- Security and risk notes
- Team workflow and analytics documentation

## Project status

This README describes the repository's current declared dependencies and intended product scope. It does not claim that all integrations, payment flows, or production deployment steps are complete. Validate each feature on its target platform before release.

## License

Proprietary. All rights reserved unless a separate written permission or licence in this repository states otherwise.
