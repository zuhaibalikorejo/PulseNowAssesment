// This file is deprecated. Please use: import 'package:pulse_plateform/core/common/core_app_colors.dart';
// Re-exporting for backward compatibility
export 'package:pulse_plateform/core/common/core_app_colors.dart';

import 'dart:ui';
import 'package:pulse_plateform/core/common/core_app_colors.dart' as new_colors;

/// @deprecated Use CoreAppColors from core/common/core_app_colors.dart instead
abstract class CoreAppColors {
  // Legacy colors - kept for backward compatibility
  static const Color colorE0FFFFFF = Color(0xE0FFFFFF);
  static const Color backgroundPage = Color(0xFFF1F3F6);
  static final Color lightBlue = Color(0xFF002f80);
  static const Color color222325 = Color(0xFF222325);
  static const Color color00D4AA = Color(0xFF00D4AA);

  // Forward to new color definitions
  static const Color primary = new_colors.CoreAppColors.primary;
  static const Color white = new_colors.CoreAppColors.white;
  static const Color background = new_colors.CoreAppColors.background;
  static const Color error = new_colors.CoreAppColors.error;
  static const Color success = new_colors.CoreAppColors.success;
}


