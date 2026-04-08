# Macro Camera | ماكرو كاميرا

Professional camera and video project management app built with Flutter.

## Features

- **Video Projects**: Organize your recordings into named projects
- **Professional Camera**: Record clips with flash, zoom, and camera switching
- **Dual Orientation**: Record once, derive both portrait (9:16) and landscape (16:9) via FFmpeg
- **Video Production**: Combine multiple clips into a final exported video
- **Dark Theme**: Beautiful Material 3 dark UI
- **Bilingual**: English and Arabic support

## Dedication

تم اهداء هذا التطبيق من محمد شريف الي نعمة عبد الله ❤️

## Tech Stack

- **Framework**: Flutter 3.24+ / Dart 3.5+
- **State Management**: Riverpod 2.x
- **Routing**: go_router
- **Camera**: camerawesome
- **Video Processing**: ffmpeg_kit_flutter
- **Database**: Isar
- **Architecture**: Feature-first Clean Architecture

## Getting Started

### Prerequisites

- Flutter SDK >= 3.24.0
- Dart SDK >= 3.5.0
- Android Studio / VS Code with Flutter extensions

### Setup

```bash
# Clone the repo
git clone https://github.com/MohamedSherif/macro-app.git
cd macro-app

# Get dependencies
flutter pub get

# Generate code (freezed, json_serializable, isar)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Building for Release

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release --split-per-abi

# App Bundle (Play Store)
flutter build appbundle --release
```

## CI/CD

This project uses GitHub Actions for automated building and releasing:

- **Build & Test**: Runs on every push/PR to `main` and `develop`
- **Release**: Triggered by pushing a git tag (e.g., `git tag v1.0.0 && git push --tags`)
- **Nightly**: Daily build at 2 AM UTC

### Required GitHub Secrets

| Secret | Description |
|--------|-------------|
| `ANDROID_KEYSTORE_BASE64` | Base64-encoded Android keystore for signing releases |
| `GITHUB_TOKEN` | Auto-provided by GitHub (for creating releases) |

## Architecture

```
lib/
├── core/              # Theme, constants, errors, utils, DI
├── domain/            # Entities, repository interfaces, use cases
├── data/              # Repository implementations, models, data sources
└── presentation/      # Screens, widgets, Riverpod providers, router
```

## Developer

**Mohamed Sherif**

---

**Macro Camera** v1.0.0 | 2026
