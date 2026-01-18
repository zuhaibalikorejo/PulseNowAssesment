


import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/domain/repositories/common_repository.dart';

/// Domain layer repository interface for cryptocurrency market operations
///
/// This abstracts the data layer implementation, allowing for different
/// implementations (API-based, stub-based, etc.) without affecting the domain layer.
abstract class MarketDataRepository extends CommonRepository{

  /// Fetches cryptocurrency market data from the data source
  /// Returns a list of cryptocurrency market information
  Future<List<MarketDataResponse>> getMarketData();

}
