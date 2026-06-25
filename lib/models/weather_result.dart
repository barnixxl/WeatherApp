import 'weather_error.dart';

class WeatherResult<T> {
  final T? data;
  final WeatherError? error;
  final Status status;

  WeatherResult.notInitialized()
      : data = null,
        error = null,
        status = Status.notInitialized;

  WeatherResult.loading({
    this.data,
  })  : error = null,
        status = Status.loading;

  WeatherResult.success(
    this.data,
  )   : error = null,
        status = Status.success;

  WeatherResult.failure(
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
