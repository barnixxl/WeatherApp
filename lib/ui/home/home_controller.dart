import 'package:mobx/mobx.dart';
import 'package:weather_app/main.dart';

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
  final Observable<double> _latitude = Observable(0.0);
  final Observable<double> _longitude = Observable(0.0);
  final Observable<String> _cityName = Observable('');

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
          WeatherError(
            errorCode: WeatherError.noGeo,
            errorMessage: strings.geo_error,
          ),
        );
      });
      return;
    }
    final result = await _repository.fetchForecast(
      _latitude.value,
      _longitude.value,
    );
    runInAction(() {
      _weatherResult.value = result;
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
      await _updateCityName(
        position.latitude,
        position.longitude,
      );
    } else {
      throw Exception(
        strings.geo_error,
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
