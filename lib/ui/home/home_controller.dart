import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';
import '../../utils/location_service.dart';

class HomeController {
  static final GetIt _getIt = GetIt.instance;
  final WeatherRepository _repository = WeatherRepository.getInstance();
  final LocationService _locationService = _getIt<LocationService>();
  final Observable<WeatherResult<List<DayWeather>>> _weatherResult =
      Observable(
    WeatherResult.notInitialized(),
  );
  final Observable<double> _latitude = Observable(53.9);
  final Observable<double> _longitude = Observable(27.5667);
  final Observable<String> _cityName = Observable('Минск');

  bool get isLoading => _weatherResult.value.isLoading;
  bool get hasError => _weatherResult.value.isError;
  bool get hasSuccess => _weatherResult.value.isSuccess;
  List<DayWeather> get dayWeather => _weatherResult.value.data ?? [];
  DateTime? get lastUpdateDate => dayWeather.firstOrNull?.date;
  WeatherError? get error => _weatherResult.value.error;
  double get latitude => _latitude.value;
  double get longitude => _longitude.value;
  String get cityName => _cityName.value;

  Future<void> loadForecast() async {
    runInAction(
      () {
        _weatherResult.value = WeatherResult.loading();
      },
    );
    await _loadCurrentLocation();
    final result = await _repository.fetchForecast(
      _latitude.value,
      _longitude.value,
    );
    runInAction(
      () {
        _weatherResult.value = result;
      },
    );
  }

  Future<void> loadForecastByCity(
    String city,
  ) async {
    runInAction(
      () {
        _weatherResult.value = WeatherResult.loading();
      },
    );
    final coordsResult = await _repository.getCoordinates(
      city,
    );
    if (coordsResult.isError) {
      runInAction(
        () {
          _weatherResult.value = WeatherResult.failure(
            coordsResult.error,
          );
        },
      );
      return;
    }
    final coords = coordsResult.data;
    if (coords != null) {
      final lat = coords['lat'] ?? 0.0;
      final lon = coords['lon'] ?? 0.0;
      runInAction(
        () {
          _latitude.value = lat;
          _longitude.value = lon;
          _cityName.value = city;
        },
      );
      final result = await _repository.fetchForecast(
        lat,
        lon,
      );
      runInAction(
        () {
          _weatherResult.value = result;
        },
      );
    }
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
      await _updateCityName(
        position.latitude,
        position.longitude,
      );
    }
  }

  Future<void> _updateCityName(
    double lat,
    double lon,
  ) async {
    final cityResult = await _repository.getCityName(
      lat,
      lon,
    );
    if (cityResult.isSuccess) {
      final city = cityResult.data;
      if (city != null) {
        runInAction(
          () {
            _cityName.value = city;
          },
        );
      }
    }
  }
}
