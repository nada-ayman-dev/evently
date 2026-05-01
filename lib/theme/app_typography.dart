import 'package:flutter/material.dart';

class AppTypography {
  // 24/24 (SBold) - Largest heading
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semi-Bold
    height: 1.0, // 24 line height
    letterSpacing: 0,
  );

  // 20/20 (SBold) - Large heading
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, // Semi-Bold
    height: 1.0, // 20 line height
    letterSpacing: 0,
  );

  // 18/18 (M) - Medium heading
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    height: 1.0, // 18 line height
    letterSpacing: 0,
  );

  // 16/16 (R) 150% - Body text with 1.5 line height
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5, // 150% line height = 24px
    letterSpacing: 0,
  );

  // 14/14 (R) - Small body text
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0, // 14 line height
    letterSpacing: 0,
  );

  // 12/12 (R) - Extra small text
  static const TextStyle xs = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
  );
}
