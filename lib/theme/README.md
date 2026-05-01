# App Theme Setup

This folder contains all theme-related configurations for the Evently app.

## Files

### `app_typography.dart`

Contains all typography styles for the app:

- **heading24SBold** - 24pt Semi-Bold (main headings)
- **heading20SBold** - 20pt Semi-Bold (sub-headings)
- **heading18Medium** - 18pt Medium (section headings)
- **body16Regular** - 16pt Regular with 150% line height (body text)
- **body14Regular** - 14pt Regular (small body text)
- **caption12Regular** - 12pt Regular (captions)

### `app_colors.dart`

Defines all color constants used throughout the app:

- Primary, secondary, and neutral colors
- Status colors (success, error, warning, info)
- Shade variations for better flexibility

### `theme.dart`

Barrel export file for easy importing of all theme files.

## Usage

### Import Theme Files

```dart
import 'package:evently/theme/theme.dart';

// Or import specific files
import 'package:evently/theme/app_typography.dart';
import 'package:evently/theme/app_colors.dart';
```

### Using Typography

```dart
Text(
  'Your Text',
  style: AppTypography.heading24SBold,
)

Text(
  'Body Text',
  style: AppTypography.body16Regular,
)
```

### Using Colors

```dart
Container(
  color: AppColors.primary,
  child: Text(
    'Colored Text',
    style: TextStyle(color: AppColors.white),
  ),
)
```

## Font Files

Place your Poppins font files in `assets/fonts/`:

- `Poppins-Regular.ttf` (weight: 400)
- `Poppins-Medium.ttf` (weight: 500)
- `Poppins-SemiBold.ttf` (weight: 600)
- `Poppins-Bold.ttf` (weight: 700)

These are already configured in `pubspec.yaml`.

## Asset Folders

The following asset folders are configured:

- `assets/images/` - Regular images
- `assets/svg/` - SVG images
- `assets/icons/` - Icon files
