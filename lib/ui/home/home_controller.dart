import 'package:mobx/mobx.dart';

import '../../models/day_weather.dart';
import '../../models/forecast_result.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../repository/weather_repository.dart';
import '../../utils/location_service.dart';

class HomeController {
  final WeatherRepository _repository = WeatherRepository.getInstance();
  final LocationService _locationService = LocationService.getInstance();

  final Observable<WeatherResult<ForecastResult>> _weatherResult = Observable(
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
    runInAction(() {
      _weatherResult.value = WeatherResult.loading();
    });
    final serviceEnabled = await _locationService.isLocationServiceEnabled();
    if (serviceEnabled) {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        final result = await _repository.fetchForecast(
          position.latitude,
          position.longitude,
        );
        runInAction(() {
          _weatherResult.value = result;
        });
        return;
      }
      runInAction(() {
        _weatherResult.value = WeatherResult.failure(
          WeatherError.noGeo(),
        );
      });
      return;
    }
    runInAction(() {
      _weatherResult.value = WeatherResult.failure(
        WeatherError.gpsDisabled(),
      );
    });
  }
}
