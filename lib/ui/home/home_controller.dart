import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';
import '../../utils/location_service.dart';

class HomeController {
  final WeatherRepository _repository = WeatherRepository.getInstance();
  final LocationService _locationService = LocationService.getInstance();

  final Observable<WeatherResult<List<DayWeather>>> _weatherResult = Observable(
    WeatherResult.notInitialized(),
  );
  final Observable<double> _latitude = Observable(
    0.0,
  );
  final Observable<double> _longitude = Observable(
    0.0,
  );
  final Observable<String> _cityName = Observable(
    '',
  );

  bool get isLoading => _weatherResult.value.isLoading;

  bool get hasError => _weatherResult.value.isError;

  bool get hasSuccess => _weatherResult.value.isSuccess;

  List<DayWeather> get dayWeather => _weatherResult.value.data ?? [];

  DateTime? get lastUpdateDate => dayWeather.firstOrNull?.date;

  WeatherError? get error => _weatherResult.value.error;

  double get latitude => _latitude.value;

  double get longitude => _longitude.value;

  String get cityName => _cityName.value;

  Future<void> onRefreshPressed() async {
    runInAction(() {
      _weatherResult.value = WeatherResult.loading();
    });
    try {
      await _loadCurrentLocation();
    } catch (e) {
      runInAction(() {
        _weatherResult.value = WeatherResult.failure(
          WeatherError.fromException(e),
        );
      });
      return;
    }
    final result = await _repository.fetchForecast(
      _latitude.value,
      _longitude.value,
    );
    runInAction(() {
      final data = result.data;
      if (result.isSuccess && data != null) {
        final (
          dayWeather,
          cityName,
        ) = data;
        _weatherResult.value = WeatherResult.success(
          dayWeather,
        );
        _cityName.value = cityName;
      } else {
        _weatherResult.value = WeatherResult.failure(
          result.error,
        );
      }
    });
  }

  Future<void> _loadCurrentLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      runInAction(
        () {
          _latitude.value = position.latitude;
          _longitude.value = position.longitude;
        },
      );
    } else {
      throw WeatherError.noGeo();
    }
  }
}
