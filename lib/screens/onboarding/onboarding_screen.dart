import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:evently/theme/theme.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'widgets/personalize_slide.dart';
import 'widgets/event_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _nextEventPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (_currentPage <= 1) return;

    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _getStarted() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _changeLocale(Locale locale) {
    // Theme/locale switching handled in MyApp
  }

  void _changeTheme(bool isDark) {
    // Theme/locale switching handled in MyApp
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _currentPage <= 1
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _previousPage,
                  ),
                  const Spacer(),
                  Image.asset('assets/images/logo.png', height: 40),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            if (notification.direction == ScrollDirection.forward) {
              return true;
            }
          }
          return false;
        },
        child: PageView(
          controller: _pageController,
          physics: _currentPage == 0
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          children: [
            PersonalizeSlide(
              onNext: _nextPage,
              onLocaleChanged: _changeLocale,
              onThemeChanged: _changeTheme,
            ),
            EventSlide(
              title: loc.findEventsTitle,
              description: loc.findEventsDescription,
              imagePath: 'assets/svg/OnboardingLight2.svg',
              currentPage: _currentPage,
              onNext: _nextEventPage,
              onGetStarted: _getStarted,
            ),
            EventSlide(
              title: loc.eventPlanningTitle,
              description: loc.eventPlanningDescription,
              imagePath: 'assets/svg/OnboardingLight3.svg',
              currentPage: _currentPage,
              onNext: _nextEventPage,
              onGetStarted: _getStarted,
            ),
            EventSlide(
              title: loc.connectFriendsTitle,
              description: loc.connectFriendsDescription,
              imagePath: 'assets/svg/OnboardingLight4.svg',
              isLastSlide: true,
              currentPage: _currentPage,
              onNext: _nextEventPage,
              onGetStarted: _getStarted,
            ),
          ],
        ),
      ),
    );
  }
}
