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

  bool get isNotInitialized => status == Status.notInitialized;

  @override
  String toString() {
    switch (status) {
      case Status.notInitialized:
        return 'WeatherResult.notInitialized';
      case Status.loading:
        return 'WeatherResult.loading(data: $data)';
      case Status.success:
        return 'WeatherResult.success(data: $data)';
      case Status.failure:
        return 'WeatherResult.failure(error: $error)';
    }
  }
}

enum Status {
  notInitialized,
  loading,
  success,
  failure,
}
