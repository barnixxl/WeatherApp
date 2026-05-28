import 'currency_error.dart';

class CurrencyResult<T> {
  final T? data;
  final CurrencyError? error;
  final Status status;

  CurrencyResult.notInitialized()
      : data = null,
        error = null,
        status = Status.notInitialized;

  CurrencyResult.loading({
    this.data,
  })  : error = null,
        status = Status.loading;

  CurrencyResult.success(
    this.data,
  )   : error = null,
        status = Status.success;

  CurrencyResult.failure(
    this.error,
  )   : data = null,
        status = Status.failure;

  bool get isSuccess => status == Status.success;

  bool get isLoading => status == Status.loading;

  bool get isError => status == Status.failure;
}

enum Status {
  notInitialized,
  loading,
  success,
  failure,
}
