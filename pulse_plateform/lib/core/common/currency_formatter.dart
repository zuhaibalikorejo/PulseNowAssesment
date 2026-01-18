import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Formats a number as USD currency with thousand separators
  /// Example: 43250.50 -> $43,250.50
  static String formatUSD(double? value, {int decimalPlaces = 2}) {
    if (value == null) return '\$0.00';

    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: decimalPlaces,
    );

    return formatter.format(value);
  }

  /// Formats a number as currency with automatic decimal places
  /// Uses more decimals for small values (< $1)
  static String formatCryptoPrice(double? value) {
    if (value == null) return '\$0.00';

    // For prices less than $1, show more decimal places
    if (value < 1) {
      return formatUSD(value, decimalPlaces: 4);
    } else if (value < 100) {
      return formatUSD(value, decimalPlaces: 2);
    } else {
      return formatUSD(value, decimalPlaces: 2);
    }
  }

  /// Formats a large number (like market cap) with abbreviated notation
  /// Example: 1500000000 -> $1.50B
  static String formatLargeNumber(double? value) {
    if (value == null) return '\$0';

    if (value >= 1000000000000) {
      return '\$${(value / 1000000000000).toStringAsFixed(2)}T';
    } else if (value >= 1000000000) {
      return '\$${(value / 1000000000).toStringAsFixed(2)}B';
    } else if (value >= 1000000) {
      return '\$${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(2)}K';
    } else {
      return formatUSD(value);
    }
  }

  /// Formats a percentage with + or - sign
  /// Example: 2.5 -> +2.5%, -1.3 -> -1.3%
  static String formatPercentage(double? value, {int decimalPlaces = 2}) {
    if (value == null) return '0.00%';

    final sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(decimalPlaces)}%';
  }
}

