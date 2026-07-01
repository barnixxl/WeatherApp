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

  final Observable<DateTime?> _appBarLastUpdate = Observable(
    null,
  );

  WeatherResult<ForecastData> get result => _weatherResult.value;

  static const _emptyDayWeather = <DayWeather>[];

  List<DayWeather> get dayWeather =>
      _weatherResult.value.data?.dayWeather ?? _emptyDayWeather;

  DateTime? get lastUpdateDate => _appBarLastUpdate.value;

  WeatherError? get error => _weatherResult.value.error;

  double get latitude => _weatherResult.value.data?.latitude ?? 0.0;

  double get longitude => _weatherResult.value.data?.longitude ?? 0.0;

  String get cityName => _appBarCityName.value;

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
          error: result.error!,
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
        _appBarLastUpdate.value = data.dayWeather.firstOrNull?.date;
      }
    });
  }
}
