import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';

class NetworkService {
  final String baseUrl;
  late final Dio _dio;

  NetworkService({
    required this.baseUrl,
  });

  Future<void> initializeDependencies() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(
          seconds: 20,
        ),
        receiveTimeout: const Duration(
          seconds: 20,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<WeatherResult<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final queryParams = {
        ...?queryParameters,
        'appid': AppConfig.apiKey,
      };
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParams,
      );
      return WeatherResult.success(
        response.data,
      );
    } on DioException catch (e) {
      return WeatherResult.failure(
        _mapDioError(
          e,
        ),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(
          e,
        ),
      );
    }
  }

  WeatherError _mapDioError(
    DioException e,
  ) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return WeatherError.timeout();
      case DioExceptionType.badCertificate:
        return WeatherError.badResponse(
          0,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        if (statusCode >= 500) {
          return WeatherError.serverError(
            statusCode,
          );
        }
        return WeatherError.badResponse(
          statusCode,
        );
      case DioExceptionType.cancel:
        return WeatherError.cancelled();
      case DioExceptionType.connectionError:
        return WeatherError.noInternet();
      case DioExceptionType.unknown:
        if (e.error is FormatException) {
          return WeatherError.parsing();
        }
        return WeatherError.unknown();
    }
  }
}
