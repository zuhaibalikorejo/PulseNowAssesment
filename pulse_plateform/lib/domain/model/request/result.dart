import '../response/error_details.dart';

/// Result class will be used to hold result of network call which can be
/// success (with data) or error (with error information)


/// Result class will be used to hold result of network call which can be
/// success (with data) or error (with error information)
class Result<T> with SealedResult<T> {}

class Success<T> extends Result<T> {
  T data;
  Success(this.data);
}

class AppError<T> extends Result<T> {
  ErrorDetails errorDetails;
  AppError(this.errorDetails);
}

mixin SealedResult<T> {
  R when<R>({
    required R Function(T) success,
    required R Function(ErrorDetails) error,
  }) {
    if (this is Success<T>) {
      return success.call(((this as Success).data));
    }
    if (this is AppError<T>) {
      return error.call(((this as AppError<T>).errorDetails));
    }
    throw new Exception(
        'probably you forgot to regenerate the classes? Try running flutter packages pub run build_runner build');
  }
}
