import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/forecast_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';

class HomeController {
  final WeatherRepository _repository = WeatherRepository.getInstance();

  final Observable<WeatherResult<ForecastData>> _weatherResult = Observable(
    WeatherResult.loading(),
  );

  final Observable<String> _appBarCityName = Observable(
    '',
  );

  final Observable<DateTime?> _firstForecastDate = Observable(
    null,
  );

  WeatherResult<ForecastData> get result => _weatherResult.value;

  static const _emptyDayWeather = <DayWeather>[];

  List<DayWeather> get dayWeather =>
      _weatherResult.value.data?.dayWeather ?? _emptyDayWeather;

  DateTime? get firstForecastDate => _firstForecastDate.value;

  WeatherError? get error => _weatherResult.value.error;

  double get latitude => _weatherResult.value.data?.latitude ?? 0.0;

  double get longitude => _weatherResult.value.data?.longitude ?? 0.0;

  String get cityName => _appBarCityName.value;

  bool get showLoadingContent => result.isLoading && dayWeather.isEmpty;

  bool get showErrorContent => result.isError;

  bool get showForecastContent =>
      result.isSuccess || (result.isLoading && dayWeather.isNotEmpty);

  Future<void> onRefreshPressed() async {
    _setState(
      WeatherResult.loading(data: _weatherResult.value.data),
    );
    final result = await _repository.fetchForecast();
    if (result.isSuccess) {
      _setState(
        result,
      );
    } else {
      _setState(
        WeatherResult.failure(
          data: _weatherResult.value.data,
          error: result.error ?? WeatherError.unknown(),
        ),
      );
    }
  }

  void _setState(
    WeatherResult<ForecastData> value,
  ) {
    runInAction(() {
      _weatherResult.value = value;
      final data = value.data;
      if (data != null) {
        _appBarCityName.value = data.cityName;
        _firstForecastDate.value = data.dayWeather.firstOrNull?.date;
      }
    });
  }
}
