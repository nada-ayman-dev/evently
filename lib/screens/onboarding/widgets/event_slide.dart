import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently/theme/theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'dots_indicator.dart';

class EventSlide extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastSlide;
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const EventSlide({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastSlide = false,
    required this.currentPage,
    required this.onNext,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(imagePath, height: 250),
                  const SizedBox(height: 24),
                  DotsIndicator(currentPage: currentPage),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: AppTypography.title,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      description,
                      textAlign: TextAlign.left,
                      style: AppTypography.body,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 343,
              height: 48,
              child: ElevatedButton(
                onPressed: isLastSlide ? onGetStarted : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkButton
                      : AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isLastSlide ? loc.getStarted : loc.next,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
