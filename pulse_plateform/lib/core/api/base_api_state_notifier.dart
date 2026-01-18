
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_plateform/core/api/api_state.dart';
import 'package:pulse_plateform/domain/model/request/result.dart';
import 'package:pulse_plateform/domain/model/response/error_details.dart';


abstract class BaseApiStateNotifier<T> extends StateNotifier<ApiState<T>> {
  BaseApiStateNotifier(super.state);

  Future<void> executeApiCall<R>({
    required Future<Result<R>?> Function() requestCall,
    required Ref ref,
    bool showError = true,
    bool showLoader = true,
    bool isUpliftErrorDialog = true,
    bool showCommonError = false,
  }) async {
    if (!state.apiTriggered) {
      return;
    }
    state = ApiState<T>(isLoading: true, apiTriggered: false);
    if (showLoader) {
      showProgress(ref);
    }
    try {
      final response = await requestCall();
      response?.when(success: (data) {
        state = ApiState<T>(isLoading: false, data: data as T, apiTriggered: true);
        if (showLoader) {
          dismissProgress(ref);
        }
      }, error: (errorDetail) {
        var appError = ErrorDetails(code: errorDetail.code ?? '', message: errorDetail.message ?? '');
        if (showError) {
          if (showCommonError) {
            state = ApiState<T>(isLoading: false, error: appError, apiTriggered: true);
            if (showLoader) {
              dismissProgress(ref);
            }
          } else {
            showErrorDialog(appError, isUpliftErrorDialog, showLoader, ref);
          }
        } else {
          if (showLoader) {
            dismissProgress(ref);
          }
          state = ApiState<T>(isLoading: false, error: appError, apiTriggered: true);
        }
      });
    } catch (e) {
      if (showError) {
        showErrorDialog(ErrorDetails(code: "", message: e.toString()), isUpliftErrorDialog, showLoader, ref);
      }
    }
  }

  showErrorDialog(ErrorDetails errorDetails, bool isUpliftErrorDialog, bool showLoader, Ref ref) {
    state = ApiState<T>(isLoading: false, error: errorDetails, apiTriggered: true);
    if (showLoader) {
      dismissProgress(ref);
    }
  }

// ############# loader #############
  final loadingProvider = StateProvider<bool>((ref) => false);
  void dismissProgress(Ref ref) {
    ref.read(loadingProvider.notifier).state = false;
  }


  void showProgress(Ref ref) {
    ref.read(loadingProvider.notifier).state = true;
  }
}
