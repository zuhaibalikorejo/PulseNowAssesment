import 'package:flutter/material.dart';

/// Centralized color definitions for the entire app
/// All color values should be accessed through this class
class CoreAppColors {
  // Private constructor to prevent instantiation
  CoreAppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryAccent = Color(0xFF00D4FF);

  // Background Colors
  static const Color background = Color(0xFFF8F9FD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color colorE0FFFFFF = Color(0xE0FFFFFF); // Legacy status bar color
  static const Color backgroundPage = Color(0xFFF1F3F6); // Legacy background

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLabel = Color(0xFF9E9E9E);
  static const Color color222325 = Color(0xFF222325);
  // Status Colors
  static const Color success = Color(0xFF00D4AA);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6C63FF),
    Color(0xFF00D4FF),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFF8F9FD),
  ];

  static const List<Color> successGradient = [
    Color(0xFF00D4AA),
    Color(0xFF00E5C0),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFFF6B6B),
    Color(0xFFFF8787),
  ];

  // Border Colors
  static final Color borderLight = Colors.grey.shade200;
  static final Color borderMedium = Colors.grey.shade300;
  static final Color borderDark = Colors.grey.shade400;

  // Shadow Colors
  static final Color primaryShadow = primary.withAlpha(20); // 0.08 opacity
  static final Color cardShadow = Colors.black.withAlpha(13); // 0.05 opacity

  // Grey Shades
  static final Color grey50 = Colors.grey.shade50;
  static final Color grey100 = Colors.grey.shade100;
  static final Color grey200 = Colors.grey.shade200;
  static final Color grey300 = Colors.grey.shade300;
  static final Color grey400 = Colors.grey.shade400;
  static final Color grey500 = Colors.grey.shade500;
  static final Color grey600 = Colors.grey.shade600;
  static final Color grey700 = Colors.grey.shade700;
  static final Color grey800 = Colors.grey.shade800;
  static final Color grey900 = Colors.grey.shade900;
}

