import 'package:pulse_plateform/core/common/build_configs.dart';
import 'package:pulse_plateform/domain/repositories/market_data_api_repository.dart';
import 'package:pulse_plateform/domain/repositories/market_data_repository.dart';
import 'package:pulse_plateform/domain/repositories/market_data_stub_repository.dart';

class MarketDataRepositoryFactory {
  static MarketDataRepository getRepository() {
    if (BuildConfigurations.stubEnabled) {
      return MarketDataStubRepository.INSTANCE;
    } else {
      return MarketDataApiRepository.INSTANCE;
    }
  }
}
