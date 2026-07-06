import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/currency_error.dart';
import '../models/currency_result.dart';

class CurrencyRateNetwork {
  static const String _baseUrl = 'https://api.nbrb.by/exrates/';
  late final Dio _dio;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<CurrencyRateNetwork>(
      this,
    );
  }

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

  Future<CurrencyResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return CurrencyResult.success(
        response.data as T,
      );
    } on DioException catch (e) {
      return CurrencyResult.failure(_mapDioError(e));
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }

  CurrencyError _mapDioError(
    DioException e,
  ) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return CurrencyError.timeout();
      case DioExceptionType.badCertificate:
        return CurrencyError.badResponse(
          0,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        return CurrencyError.badResponse(
          statusCode,
        );
      case DioExceptionType.cancel:
        return CurrencyError.cancelled();
      case DioExceptionType.connectionError:
        return CurrencyError.noInternet();
      case DioExceptionType.unknown:
        if (e.error is FormatException) {
          return CurrencyError.parsing();
        }
        return CurrencyError.unknown();
    }
  }
}
