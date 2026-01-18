
import 'package:pulse_plateform/core/common/market_data_constant.dart';
import 'package:pulse_plateform/core/common/network_error.dart';
import 'package:pulse_plateform/domain/model/request/result.dart';
import 'package:pulse_plateform/domain/model/response/api_response.dart';
import 'package:pulse_plateform/domain/model/response/error_details.dart';

abstract class AbstractUseCase {
  Future<Result<T>> parseAndHandleError<T extends ApiResponse>(Future<T> apiCall) => apiCall.then((T? response) {
    if (response == null) {
      return AppError(ErrorDetails(
        code: NetworkError.SYS_DEFAULT_ERROR,
        message: MarketDataConstant.systemMaintainanceError,
      ));
    }
    return Success(response);
  });





}
