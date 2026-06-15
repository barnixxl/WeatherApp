import 'package:get_it/get_it.dart';

//import '../models/coordinates.dart';
import '../models/day_weather.dart';
import '../models/weather_data.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';
import '../network/weather/weather_api.dart';
import '../network/geocoding/geocoding_api.dart';
import 'base_repository.dart';

class WeatherRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherApi _weatherApi;
  late final GeocodingApi _geocodingApi;

  @override
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherRepository>(
      this,
    );
  }

  @override
  Future<void> initializeDependencies() async {
    _weatherApi = _getIt<WeatherApi>();
    _geocodingApi = _getIt<GeocodingApi>();
  }

  static WeatherRepository getInstance() {
    return _getIt<WeatherRepository>();
  }

  Future<WeatherResult<List<DayWeather>>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final result = await _weatherApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isSuccess) {
      final weatherList = result.data;
      if (weatherList == null) {
        return WeatherResult.failure(
          WeatherError.loadFailed(),
        );
      }
      final grouped = _groupByDay(
        weatherList,
      );
      final filtered = _filterHourlyData(
        grouped,
      );
      return WeatherResult.success(
        filtered,
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }

  // Future<WeatherResult<Coordinates>> getCoordinates( - если добавится обработка ошибок
  //   String cityName,
  // ) async {
  //   return _geocodingApi.getCoordinates(
  //     cityName,
  //   );
  // }

  Future<WeatherResult<String>> getCityName(
    double lat,
    double lon,
  ) async {
    return _geocodingApi.getCityName(
      lat,
      lon,
    );
  }

  List<DayWeather> _groupByDay(
    List<WeatherData> weatherList,
  ) {
    final Map<String, List<WeatherData>> grouped = {};
    for (final weather in weatherList) {
      final dateKey = _getDateKey(
        weather.dateTime,
      );
      grouped
          .putIfAbsent(
            dateKey,
            () => [],
          )
          .add(
            weather,
          );
    }
    return grouped.entries.map(
      (entry) {
        final date = DateTime.parse(
          entry.key,
        );
        return DayWeather(
          date: date,
          hourlyData: entry.value,
        );
      },
    ).toList();
  }

  String _getDateKey(
    DateTime dateTime,
  ) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  List<DayWeather> _filterHourlyData(
    List<DayWeather> dayWeatherList,
  ) {
    return dayWeatherList.map(
      (dayWeather) {
        final filtered = dayWeather.hourlyData.where(
          (weather) {
            final hour = weather.dateTime.hour;
            return hour % 2 == 0;
          },
        ).toList();
        return DayWeather(
          date: dayWeather.date,
          hourlyData: filtered,
        );
      },
    ).toList();
  }
}
