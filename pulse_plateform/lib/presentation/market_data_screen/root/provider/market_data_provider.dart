import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_plateform/core/common/error_handler.dart';
import 'package:pulse_plateform/presentation/market_data_screen/root/provider/market_data_api_provider.dart';

final marketDataProvider = Provider<MarketDataProvider>(
  (ref) => MarketDataProvider(),
);

/// Provider for managing cryptocurrency market data operations
class MarketDataProvider {

  /// Fetches cryptocurrency market data from the API
  /// Displays error messages to the user if the operation fails
  Future<void> fetchMarketData(WidgetRef ref, BuildContext context) async {
    await ref.read(marketDataNotifierProvider.notifier)
        .fetchMarketData(showError: true);

    var marketDataState = ref.read(marketDataNotifierProvider);

    if (marketDataState.data != null && marketDataState.data!.isNotEmpty) {
      print('Loaded ${marketDataState.data!.length} cryptocurrencies');
    } else {
      var error = marketDataState.error;
      if (error != null) {
        print('Error loading market data: ${error.message}');
        // Display error message to user
        final errorMessage = ErrorHandler.getUserFriendlyMessage(
          error.code,
          error.message,
        );
        // Check if context is still mounted before showing SnackBar
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, errorMessage);
        }
      }
    }
  }

}
