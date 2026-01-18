import 'package:flutter/material.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';

import 'package:pulse_plateform/core/common/market_data_constant.dart';
import 'package:pulse_plateform/core/common/network_error.dart';
import 'package:pulse_plateform/resources/dimens.dart';
import 'package:pulse_plateform/widget/market_data_textview.dart';

class ErrorHandler {
  /// Shows a SnackBar with error message
  static void showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MarketDataTextView(message),
        backgroundColor: CoreAppColors.error,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: MarketDataConstant.dismiss,
          textColor: CoreAppColors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Shows an AlertDialog with error details
  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? errorCode,
  }) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.error_outline, color: CoreAppColors.error, size: dimen24),
              const SizedBox(width: dimen8),
              MarketDataTextView(title),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              if (errorCode != null && errorCode.isNotEmpty) ...[
                const SizedBox(height: dimen8),
                MarketDataTextView(
                  'Error Code: $errorCode',
                  style: const TextStyle(
                    fontSize: dimen12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: MarketDataTextView(MarketDataConstant.ok),
            ),
          ],
        );
      },
    );
  }

  /// Returns a user-friendly error message based on error code
  static String getUserFriendlyMessage(String? errorCode, String? originalMessage) {
    if (errorCode == null) return originalMessage ?? 'An unknown error occurred';

    switch (errorCode) {
      case NetworkError.SYS_TECHNICAL_ERROR:
        return MarketDataConstant.technicalError;
      case NetworkError.SYS_DEFAULT_ERROR:
        return MarketDataConstant.defaultError;
      case NetworkError.API_TIMEOUT:
        return MarketDataConstant.timeOut;
      case NetworkError.NO_RECROD_FOUND:
        return MarketDataConstant.noRecordFound;
      default:
        return originalMessage ?? 'An error occurred. Please try again.';
    }
  }
}

