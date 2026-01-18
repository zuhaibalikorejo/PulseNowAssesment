

import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_plateform/domain/model/response/api_response.dart';
import 'package:pulse_plateform/domain/model/response/error_info.dart';

part 'market_data_response.g.dart';

@JsonSerializable(includeIfNull: false)
class MarketDataResponse extends ApiResponse {
  String? id;
  String? symbol;
  String? name;
  String? image;

  @JsonKey(name: 'current_price')
  double? currentPrice;

  @JsonKey(name: 'market_cap')
  double? marketCap;

  @JsonKey(name: 'market_cap_rank')
  int? marketCapRank;

  @JsonKey(name: 'fully_diluted_valuation')
  double? fullyDilutedValuation;

  @JsonKey(name: 'total_volume')
  double? totalVolume;

  @JsonKey(name: 'high_24h')
  double? high24h;

  @JsonKey(name: 'low_24h')
  double? low24h;

  @JsonKey(name: 'price_change_24h')
  double? priceChange24h;

  @JsonKey(name: 'price_change_percentage_24h')
  double? priceChangePercentage24h;

  @JsonKey(name: 'market_cap_change_24h')
  double? marketCapChange24h;

  @JsonKey(name: 'market_cap_change_percentage_24h')
  double? marketCapChangePercentage24h;

  @JsonKey(name: 'circulating_supply')
  double? circulatingSupply;

  @JsonKey(name: 'total_supply')
  double? totalSupply;

  @JsonKey(name: 'max_supply')
  double? maxSupply;

  double? ath;

  @JsonKey(name: 'ath_change_percentage')
  double? athChangePercentage;

  @JsonKey(name: 'ath_date')
  String? athDate;

  double? atl;

  @JsonKey(name: 'atl_change_percentage')
  double? atlChangePercentage;

  @JsonKey(name: 'atl_date')
  String? atlDate;

  dynamic roi;

  @JsonKey(name: 'last_updated')
  String? lastUpdated;

  MarketDataResponse({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
  });

  factory MarketDataResponse.fromJson(Map<String, dynamic> data) =>
      _$MarketDataResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$MarketDataResponseToJson(this);
}
