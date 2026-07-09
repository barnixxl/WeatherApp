import '../main.dart';

class WeatherError {
  final int errorCode;
  final String errorMessage;

  const WeatherError({
    required this.errorCode,
    required this.errorMessage,
  });

  static const int unknownCode = -1;
  static const int timeoutCode = 1;
  static const int noInternetCode = 2;
  static const int serverCode = 3;
  static const int badResponseCode = 4;
  static const int cancelledCode = 5;
  static const int parsingCode = 6;
  static const int noDataCode = 7;
  static const int noGeoCode = 8;
  static const int loadFailedCode = 9;
  static const int configErrorCode = 10;
  static const int invalidDataCode = 11;
  static const int gpsDisabledCode = 12;
  static const int locationTimeoutCode = 13;

  @override
  String toString() => errorMessage;

  factory WeatherError.fromException(
    Object e,
  ) {
    if (e is WeatherError) {
      return e;
    }
    return WeatherError(
      errorCode: unknownCode,
      errorMessage: strings.error_unknown,
    );
  }

  factory WeatherError.timeout() => WeatherError(
        errorCode: timeoutCode,
        errorMessage: strings.error_timeout,
      );

  factory WeatherError.noInternet() => WeatherError(
        errorCode: noInternetCode,
        errorMessage: strings.error_no_internet,
      );

  factory WeatherError.serverError(
    int statusCode,
  ) =>
      WeatherError(
        errorCode: serverCode,
        errorMessage: strings.error_server(
          statusCode,
        ),
      );

  factory WeatherError.badResponse(
    int statusCode,
  ) =>
      WeatherError(
        errorCode: badResponseCode,
        errorMessage: strings.error_bad_response(
          statusCode,
        ),
      );

  factory WeatherError.cancelled() => WeatherError(
        errorCode: cancelledCode,
        errorMessage: strings.error_cancelled,
      );

  factory WeatherError.unknown() => WeatherError(
        errorCode: unknownCode,
        errorMessage: strings.error_unknown,
      );

  factory WeatherError.parsing() => WeatherError(
        errorCode: parsingCode,
        errorMessage: strings.error_parsing,
      );

  factory WeatherError.noData() => WeatherError(
        errorCode: noDataCode,
        errorMessage: strings.error_no_data,
      );

  factory WeatherError.noGeo() => WeatherError(
        errorCode: noGeoCode,
        errorMessage: strings.geo_error,
      );

  factory WeatherError.loadFailed() => WeatherError(
        errorCode: loadFailedCode,
        errorMessage: strings.error_load_failed,
      );

  factory WeatherError.configError() => WeatherError(
        errorCode: configErrorCode,
        errorMessage: strings.error_config,
      );

  factory WeatherError.invalidData() => WeatherError(
        errorCode: invalidDataCode,
        errorMessage: strings.error_invalid_data,
      );

  factory WeatherError.gpsDisabled() => WeatherError(
        errorCode: gpsDisabledCode,
        errorMessage: strings.error_gps_disabled,
      );

  factory WeatherError.locationTimeout() => WeatherError(
        errorCode: locationTimeoutCode,
        errorMessage: strings.error_location_timeout,
      );
}
