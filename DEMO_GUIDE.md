# Veltrix Sports — Demo Guide

## Quick Start (3 Platforms on Windows)

### 1. Web (Chrome/Edge) — Already Running
- **URL**: http://localhost:8080
- **Dark Mode**: Click the sun/moon icon in the top navigation bar
- **Features**: Landing page, Training, Events, Coaches, Pricing, About, Contact

### 2. Mobile (Android Emulator)
```bash
# Start the Pixel 5 emulator
flutter emulators --launch Pixel_5

# Wait for boot, then run
flutter run -d emulator
```
- **Dark Mode**: Settings screen → Dark Mode toggle
- **Shows**: All 21 screens (Splash, Onboarding, Auth, Home, Training, Events, etc.)

### 3. iOS Simulation
- **Not available on Windows** — iOS simulator requires macOS
- **Workaround for demo**:
  - Open Chrome → F12 (DevTools) → Toggle Device Toolbar (Ctrl+Shift+M)
  - Select "iPhone 14 Pro" from dropdown
  - Navigate to http://localhost:8080 — the Flutter web renders at mobile width
  - This shows what the iOS app would look like

---

## Demo Script for Stakeholders

### Opening (2 min)
> "Veltrix Sports is a complete sports platform with three verticals: Training Plans, Events, and Ticketing. We've built the full frontend for both mobile and web, with a professional website for acquisition and a mobile app for engagement."

### Part 1: Web Platform (3 min)
1. Show landing page — hero, features, testimonials, pricing
2. Navigate: Training → Events → Coaches → Pricing → About
3. **Toggle dark mode** — "We support both light and dark themes"
4. Show responsive layout — resize browser window

### Part 2: Mobile App (5 min)
1. Show splash screen with animated logo
2. Onboarding flow (3 pages)
3. Login screen → Sign up flow
4. Home screen with featured content
5. Training list → Training details
6. Events list → Event details
7. Tickets with QR code
8. Coach profiles
9. Progress dashboard with charts
10. **Toggle dark mode** in Settings

### Part 3: Architecture (2 min)
> "The app uses Riverpod for state management, GoRouter for navigation, and a clean architecture with repositories, providers, and models. All mock data simulates real API responses."

---

## Color Scheme (Presentation-Ready)

### Light Mode
| Element | Color | Hex |
|---------|-------|-----|
| Primary | Blue | #2563EB |
| Secondary | Green | #10B981 |
| Accent | Amber | #F59E0B |
| Background | Off-white | #F9FAFB |
| Text Primary | Dark gray | #111827 |
| Text Secondary | Gray | #6B7280 |

### Dark Mode
| Element | Color | Hex |
|---------|-------|-----|
| Primary | Light blue | #60A5FA |
| Secondary | Mint green | #34D399 |
| Accent | Light amber | #FBBF24 |
| Background | Navy | #0F172A |
| Surface | Slate | #1E293B |
| Text Primary | Light gray | #F1F5F9 |
| Text Secondary | Gray | #94A3B8 |

---

## Emulation Options

| Platform | Tool | Command | Status |
|----------|------|---------|--------|
| Web | Chrome/Edge | `http://localhost:8080` | Running |
| Android | Pixel 5 Emulator | `flutter emulators --launch Pixel_5` | Available |
| iOS | Xcode Simulator | Requires macOS | N/A on Windows |
| iOS (workaround) | Chrome DevTools | F12 → Device Toolbar → iPhone | Works |

---

## Key Demo Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | Mobile app entry (MaterialApp with light+dark theme) |
| `lib/main_web.dart` | Web app entry (separate router, desktop layout) |
| `lib/core/theme/app_theme.dart` | Light & dark themes, themeModeProvider |
| `lib/features/web/core/constants/web_colors.dart` | Web dark mode colors |
| `lib/features/web/presentation/widgets/web_scaffold.dart` | Desktop header with dark toggle |
| `scripts/demo.bat` | One-click demo launcher |
