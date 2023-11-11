# My Flutter App

## Description

This Flutter app is designed to provide [a brief description of what your app does and its main features].

## Getting Started

### Prerequisites

To run this app, you'll need [list any prerequisites, libraries, or tools necessary].

### Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/self-car-rental/scr-vendor-ui.git
cd scr-vendor-ui
flutter pub get

## Localization Steps
To add a new language:

1. Create a new ARB file in the `l10n` directory, e.g., `app_ta.arb` for Tamil, with the translated content.
2. Add the new language to `lib/constants/language_constants.dart` like this: `"'ta': 'தமிழ்',"`
3. Run `flutter pub get` to automatically generate localization files.
4. After updating any ARB file content, run `flutter pub get` again to regenerate the files.

This integrates the new language into the app, allowing dynamic language switching.
```
