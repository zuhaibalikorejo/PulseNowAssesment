


import 'package:pulse_plateform/core/api/service_invoker.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/domain/repositories/market_data_repository.dart';


class MarketDataApiRepository extends MarketDataRepository  {
  MarketDataApiRepository._privateConstructor();

  static final MarketDataApiRepository _instance = MarketDataApiRepository._privateConstructor();

  static MarketDataApiRepository get INSTANCE => _instance;



  @override
  Future<List<MarketDataResponse>> getMarketData() async {
    // Fetch top cryptocurrencies from CoinGecko API
    var response = await ServiceInvoker.INSTANCE.invoke(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false",
      serviceRequestType: ServiceRequestType.GET,
    );
    // Response is a List of cryptocurrency objects
    if (response is List) {
      return response
          .map((json) => MarketDataResponse.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Invalid response format: Expected List but got ${response.runtimeType}');
  }


}

