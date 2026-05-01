# Evently - Event Management App

A beautiful and modern Flutter application for managing events with a clean architecture and professional design system.

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/                    # Design system
│   ├── app_typography.dart   # Text styles (headline, title, subtitle, body, caption, xs)
│   ├── app_colors.dart       # Color palette
│   ├── theme.dart            # Theme exports
│   └── README.md
├── screens/                  # App screens
│   ├── splash/               # Splash screen with animations
│   │   ├── splash_screen.dart
│   │   ├── index.dart
│   │   └── README.md
│   └── index.dart
└── ...

assets/
├── images/                   # Regular images
│   └── splash.png           # Splash screen image
├── svg/                      # SVG images
├── icons/                    # Icon files
└── fonts/                    # Custom fonts (Poppins)
    ├── Poppins-Regular.ttf
    ├── Poppins-Medium.ttf
    ├── Poppins-SemiBold.ttf
    └── Poppins-Bold.ttf
```

## 🎨 Design System

### Typography

All text styles use **Poppins** font family:

- **Headline** - 24pt Semi-Bold (main headings)
- **Title** - 20pt Semi-Bold (page titles)
- **Subtitle** - 18pt Medium (section headings)
- **Body** - 16pt Regular, 150% line height (body text)
- **Caption** - 14pt Regular (small text)
- **XS** - 12pt Regular (extra small text)

**Usage:**

```dart
import 'package:evently/theme/theme.dart';

Text('Your Text', style: AppTypography.headline)
```

### Colors

All colors are defined in `AppColors` class:

- Primary, Secondary, and Neutral palettes
- Status colors (success, error, warning, info)

**Usage:**

```dart
Container(
  color: AppColors.primary,
  child: Text('Colored Text', style: TextStyle(color: AppColors.white)),
)
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.11.4 or higher
- Dart SDK

### Installation

1. Clone the repository

```bash
git clone <repository-url>
cd Evently
```

2. Install dependencies

```bash
flutter pub get
```

3. Add Poppins fonts to `assets/fonts/` directory
   - Download Poppins font files from Google Fonts
   - Place them in the fonts folder

4. Add your splash screen image
   - Save your image as `splash.png`
   - Place it in `assets/images/splash.png`

### Running the App

```bash
flutter run
```

For verbose output:

```bash
flutter run --verbose
```

## 📱 App Architecture

### Screens

Currently implemented:

- **SplashScreen** - Animated splash with 3-second delay and navigation

### Widgets & Components

Create reusable widgets in dedicated folders:

```
lib/
├── screens/           # Full page screens
├── widgets/           # Reusable widgets/components
├── models/            # Data models
├── services/          # API & business logic
└── theme/             # Design system
```

## 🔧 Configuration

### pubspec.yaml

The following are already configured:

- ✅ Poppins font family
- ✅ Asset folders (images, svg, icons)
- ✅ Material Design 3 support

## 📦 Build

### Debug Build

```bash
flutter build apk --debug
```

### Release Build

```bash
flutter build apk --release
```

### Web Build

```bash
flutter build web
```

## 🎯 Next Steps

1. Create `HomeScreen` in `lib/screens/home/`
2. Add more screens as needed
3. Implement business logic and services
4. Connect to backend APIs
5. Add state management (Provider, Bloc, Riverpod, etc.)

## 📝 Code Style

- Use `const` constructors whenever possible
- Follow Dart/Flutter naming conventions
- Use semantic naming for variables and functions
- Keep components small and reusable
- Add meaningful comments for complex logic

## 🤝 Contributing

1. Create feature branches
2. Make meaningful commits
3. Follow the project structure
4. Test thoroughly before committing

## 📄 License

This project is licensed under MIT License.

## 📧 Support

For questions or issues, please open an issue in the repository.

---

**Happy Coding! 🎉**
