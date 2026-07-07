import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/forecast_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';
import '../../utils/location_service.dart';

class HomeController {
  final WeatherRepository _repository = WeatherRepository.getInstance();

  final LocationService _locationService = LocationService.getInstance();

  final Observable<WeatherResult<ForecastData>> _weatherResult = Observable(
    WeatherResult.notInitialized(),
  );

  final Observable<String> _appBarCityName = Observable(
    '',
  );

  final Observable<DateTime?> _lastUpdateDate = Observable(
    null,
  );

  static const _emptyDayWeather = <DayWeather>[];

  List<DayWeather> get dayWeather =>
      _weatherResult.value.data?.dayWeather ?? _emptyDayWeather;

  WeatherResult<ForecastData> get result => _weatherResult.value;

  DateTime? get lastUpdateDate => _lastUpdateDate.value;

  WeatherError? get error => _weatherResult.value.error;

  double get latitude => _weatherResult.value.data?.latitude ?? 0.0;

  double get longitude => _weatherResult.value.data?.longitude ?? 0.0;

  String get cityName => _appBarCityName.value;

  bool get isLoading => result.isLoading;

  bool get hasError => result.isError;

  bool get hasSuccess => result.isSuccess;

  Future<void> onRefreshPressed() async {
    _setState(
      WeatherResult.loading(
        data: _weatherResult.value.data,
      ),
    );
    final serviceEnabled = await _locationService.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      _setState(WeatherResult.failure(
        WeatherError.gpsDisabled(),
        data: _weatherResult.value.data,
      ));
      return;
    }

    final locationResult = await _locationService.getCurrentLocation();

    final locationData = locationResult.data;
    if (locationResult.isError || locationData == null) {
      _setState(
        WeatherResult.failure(
          locationResult.error ?? WeatherError.noGeo(),
          data: _weatherResult.value.data,
        ),
      );
      return;
    }

    final result = await _repository.fetchForecast(
      locationData.latitude,
      locationData.longitude,
    );
    if (result.isSuccess) {
      _setState(
        result,
      );
    } else {
      _setState(
        WeatherResult.failure(
          result.error ?? WeatherError.unknown(),
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
        if (value.isSuccess) {
          _lastUpdateDate.value = DateTime.now();
        }
      }
    });
  }
}
