import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently/theme/theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/widgets/language_button.dart';
import 'package:evently/widgets/theme_button.dart';
import 'option_row.dart';

class PersonalizeSlide extends StatefulWidget {
  final VoidCallback onNext;
  final Function(Locale) onLocaleChanged;
  final Function(bool) onThemeChanged;

  const PersonalizeSlide({
    super.key,
    required this.onNext,
    required this.onLocaleChanged,
    required this.onThemeChanged,
  });

  @override
  State<PersonalizeSlide> createState() => _PersonalizeSlideSate();
}

class _PersonalizeSlideSate extends State<PersonalizeSlide> {
  late String _selectedLanguage;
  bool _isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguage = Localizations.localeOf(context).languageCode == 'ar'
        ? 'Arabic'
        : 'English';
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Theme colors
    final backgroundColor = _isDarkMode
        ? AppColors.darkBackground
        : AppColors.white;
    final textColor = _isDarkMode ? AppColors.darkText : AppColors.black;
    final secondaryTextColor = _isDarkMode
        ? AppColors.darkTextSecondary
        : AppColors.grey600;

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 100,
              ),
            ),
            const SizedBox(height: 8),
            SvgPicture.asset('assets/svg/OnboardingLight1.svg', height: 250),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                loc.personalizeTitle,
                textAlign: TextAlign.left,
                style: AppTypography.title.copyWith(color: textColor),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                loc.personalizeDescription,
                textAlign: TextAlign.left,
                style: AppTypography.subtitle.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            OptionRow(
              title: loc.languageLabel,
              children: [
                LanguageButton(
                  language: loc.englishLanguage,
                  isSelected: _selectedLanguage == 'English',
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'English';
                    });
                    widget.onLocaleChanged(const Locale('en'));
                  },
                ),
                const SizedBox(width: 8),
                LanguageButton(
                  language: loc.arabicLanguage,
                  isSelected: _selectedLanguage == 'Arabic',
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'Arabic';
                    });
                    widget.onLocaleChanged(const Locale('ar'));
                  },
                ),
              ],
            ),
            OptionRow(
              title: loc.themeLabel,
              children: [
                ThemeButton(
                  isDark: false,
                  isSelected: _isDarkMode == false,
                  onTap: () {
                    setState(() {
                      _isDarkMode = false;
                    });
                    widget.onThemeChanged(false);
                  },
                ),
                const SizedBox(width: 8),
                ThemeButton(
                  isDark: true,
                  isSelected: _isDarkMode == true,
                  onTap: () {
                    setState(() {
                      _isDarkMode = true;
                    });
                    widget.onThemeChanged(true);
                  },
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 343,
                height: 48,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E3A99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    loc.letsStart,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
