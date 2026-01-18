// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketDataResponse _$MarketDataResponseFromJson(Map<String, dynamic> json) =>
    MarketDataResponse(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      marketCap: (json['market_cap'] as num?)?.toDouble(),
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt(),
      fullyDilutedValuation:
          (json['fully_diluted_valuation'] as num?)?.toDouble(),
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      high24h: (json['high_24h'] as num?)?.toDouble(),
      low24h: (json['low_24h'] as num?)?.toDouble(),
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble(),
      marketCapChange24h: (json['market_cap_change_24h'] as num?)?.toDouble(),
      marketCapChangePercentage24h:
          (json['market_cap_change_percentage_24h'] as num?)?.toDouble(),
      circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
      totalSupply: (json['total_supply'] as num?)?.toDouble(),
      maxSupply: (json['max_supply'] as num?)?.toDouble(),
      ath: (json['ath'] as num?)?.toDouble(),
      athChangePercentage: (json['ath_change_percentage'] as num?)?.toDouble(),
      athDate: json['ath_date'] as String?,
      atl: (json['atl'] as num?)?.toDouble(),
      atlChangePercentage: (json['atl_change_percentage'] as num?)?.toDouble(),
      atlDate: json['atl_date'] as String?,
      roi: json['roi'],
      lastUpdated: json['last_updated'] as String?,
    )..errorInfo = json['errorInfo'] == null
        ? null
        : ErrorInfo.fromJson(json['errorInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$MarketDataResponseToJson(MarketDataResponse instance) =>
    <String, dynamic>{
      if (instance.errorInfo case final value?) 'errorInfo': value,
      if (instance.id case final value?) 'id': value,
      if (instance.symbol case final value?) 'symbol': value,
      if (instance.name case final value?) 'name': value,
      if (instance.image case final value?) 'image': value,
      if (instance.currentPrice case final value?) 'current_price': value,
      if (instance.marketCap case final value?) 'market_cap': value,
      if (instance.marketCapRank case final value?) 'market_cap_rank': value,
      if (instance.fullyDilutedValuation case final value?)
        'fully_diluted_valuation': value,
      if (instance.totalVolume case final value?) 'total_volume': value,
      if (instance.high24h case final value?) 'high_24h': value,
      if (instance.low24h case final value?) 'low_24h': value,
      if (instance.priceChange24h case final value?) 'price_change_24h': value,
      if (instance.priceChangePercentage24h case final value?)
        'price_change_percentage_24h': value,
      if (instance.marketCapChange24h case final value?)
        'market_cap_change_24h': value,
      if (instance.marketCapChangePercentage24h case final value?)
        'market_cap_change_percentage_24h': value,
      if (instance.circulatingSupply case final value?)
        'circulating_supply': value,
      if (instance.totalSupply case final value?) 'total_supply': value,
      if (instance.maxSupply case final value?) 'max_supply': value,
      if (instance.ath case final value?) 'ath': value,
      if (instance.athChangePercentage case final value?)
        'ath_change_percentage': value,
      if (instance.athDate case final value?) 'ath_date': value,
      if (instance.atl case final value?) 'atl': value,
      if (instance.atlChangePercentage case final value?)
        'atl_change_percentage': value,
      if (instance.atlDate case final value?) 'atl_date': value,
      if (instance.roi case final value?) 'roi': value,
      if (instance.lastUpdated case final value?) 'last_updated': value,
    };
