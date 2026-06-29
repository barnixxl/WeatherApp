import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/forecast_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';

class HomeController {
  final WeatherRepository _repository = WeatherRepository.getInstance();

  final Observable<WeatherResult<ForecastData>> _weatherResult = Observable(
    WeatherResult.notInitialized(),
  );

  bool get isLoading => _weatherResult.value.isLoading;

  bool get hasError => _weatherResult.value.isError;

  bool get hasSuccess => _weatherResult.value.isSuccess;

  List<DayWeather> get dayWeather =>
      _weatherResult.value.data?.dayWeather ?? [];

  DateTime? get lastUpdateDate => dayWeather.firstOrNull?.date;

  WeatherError? get error => _weatherResult.value.error;

  double get latitude => _weatherResult.value.data?.latitude ?? 0.0;

  double get longitude => _weatherResult.value.data?.longitude ?? 0.0;

  String get cityName => _weatherResult.value.data?.cityName ?? '';

  Future<void> onRefreshPressed() async {
    _setState(
      WeatherResult.loading(),
    );
    final result = await _repository.fetchForecast();
    _setState(
      result,
    );
  }

  void _setState(
    WeatherResult<ForecastData> value,
  ) {
    runInAction(() {
      _weatherResult.value = value;
    });
  }
}
