import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/domain/repositories/market_data_repository.dart';

class MarketDataStubRepository extends MarketDataRepository  {
  MarketDataStubRepository._privateConstructor();

  static final MarketDataStubRepository _instance = MarketDataStubRepository._privateConstructor();

  static MarketDataStubRepository get INSTANCE => _instance;



  @override
  Future<List<MarketDataResponse>> getMarketData() async {
    await Future.delayed(const Duration(seconds: 2));
    final String response = await rootBundle.loadString("assets/stubs/crypto_product.json");
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => MarketDataResponse.fromJson(json)).toList();
  }


}
