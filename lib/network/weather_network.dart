import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';

class WeatherNetwork {
  static final GetIt _getIt = GetIt.instance;
  late final Dio _dio;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherNetwork>(
      this,
    );
  }

  static WeatherNetwork getInstance() {
    return _getIt<WeatherNetwork>();
  }

  Future<void> initializeDependencies() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
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
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: false,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  Future<WeatherResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data != null) {
        return WeatherResult.success(
          data,
        );
      }
      return WeatherResult.failure(
        WeatherError.loadFailed(),
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
