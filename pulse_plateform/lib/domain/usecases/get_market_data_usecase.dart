
import 'package:pulse_plateform/core/common/market_data_constant.dart';
import 'package:pulse_plateform/core/common/network_error.dart';
import 'package:pulse_plateform/domain/model/request/result.dart';
import 'package:pulse_plateform/domain/model/response/error_details.dart';
import 'package:pulse_plateform/domain/model/response/market_data_response.dart';
import 'package:pulse_plateform/domain/repositories/market_data_repository.dart';
import 'package:pulse_plateform/domain/usecases/base_usecase.dart';

/// Use case for fetching cryptocurrency market data
/// Handles business logic and error handling for market data retrieval
class GetMarketDataUseCase extends BaseUseCase<NoParams, Result<List<MarketDataResponse>>> {
  final MarketDataRepository marketDataRepository;

  GetMarketDataUseCase(this.marketDataRepository);

  @override
  Future<Result<List<MarketDataResponse>>> execute(NoParams request) async {
    try {
      final response = await marketDataRepository.getMarketData();

      if (response.isEmpty) {
        return AppError(ErrorDetails(
          code: NetworkError.NO_RECROD_FOUND,
          message: MarketDataConstant.noRecordFound,
        ));
      }

      return Success(response);
    } catch (e) {
      return AppError(ErrorDetails(
        code: NetworkError.SYS_DEFAULT_ERROR,
        message: e.toString(),
      ));
    }
  }
}
