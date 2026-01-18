


import 'package:pulse_plateform/domain/model/response/error_details.dart';

class ApiState<T> {
  final bool isLoading;
  final T? data;
  final ErrorDetails? error;
  final bool apiTriggered;

  ApiState({this.isLoading = false, this.data, this.error, this.apiTriggered = true});

  ApiState<T> copyWith({bool? isLoading, T? data, ErrorDetails? error, bool? apiTriggered}) {
    return ApiState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
      apiTriggered: apiTriggered ?? this.apiTriggered,
    );
  }
}
