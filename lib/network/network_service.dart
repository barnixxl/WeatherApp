import 'package:dio/dio.dart';

import '../models/weather_error.dart';
import '../models/weather_result.dart';

class NetworkService {
  final String _baseUrl;
  final Map<String, dynamic> _defaultQueryParams;
  late final Dio _dio;

  NetworkService({
    required String baseUrl,
    Map<String, dynamic>? defaultQueryParams,
  })  : _baseUrl = baseUrl,
        _defaultQueryParams = defaultQueryParams ?? {};

  Future<void> initializeDependencies() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
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
        ..._defaultQueryParams,
        ...?queryParameters,
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
