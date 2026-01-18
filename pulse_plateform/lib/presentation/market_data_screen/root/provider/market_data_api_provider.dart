
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_plateform/core/api/api_state.dart';
import 'package:pulse_plateform/core/api/base_api_state_notifier.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/domain/repositories/market_data_repository_factory.dart';
import 'package:pulse_plateform/domain/usecases/base_usecase.dart';
import 'package:pulse_plateform/domain/usecases/get_market_data_usecase.dart';

// Top-level providers for market data
final getMarketDataUseCaseProvider = Provider<GetMarketDataUseCase>((ref) {
  return GetMarketDataUseCase(MarketDataRepositoryFactory.getRepository());
});

final marketDataNotifierProvider = StateNotifierProvider<
    MarketDataApiProvider<List<MarketDataResponse>>,
    ApiState<List<MarketDataResponse>>>(
  (ref) => MarketDataApiProvider<List<MarketDataResponse>>(
    ref,
    ref.read(getMarketDataUseCaseProvider),
  ),
);

/// API provider for cryptocurrency market data
/// Manages state and API calls for fetching market information
class MarketDataApiProvider<T> extends BaseApiStateNotifier<T> {
  final Ref ref;
  final GetMarketDataUseCase _getMarketDataUseCase;

  MarketDataApiProvider(this.ref, this._getMarketDataUseCase) : super(ApiState());

  /// Fetches the cryptocurrency market data list
  Future<void> fetchMarketData({bool showError = true}) async {
    // Delay state modification to avoid modifying providers during build
    await Future.microtask(() async {
      await executeApiCall(
        requestCall: () => _getMarketDataUseCase.execute(const NoParams()),
        ref: ref,
        showError: showError,
        showCommonError: true,
        showLoader: false,
      );
    });
  }
}

