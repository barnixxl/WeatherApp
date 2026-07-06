import '../main.dart';

class CurrencyError {
  final int errorCode;
  final String errorMessage;

  const CurrencyError({
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
  static const int loadFailedCode = 8;

  @override
  String toString() => errorMessage;

  factory CurrencyError.fromException(
    Object e,
  ) {
    if (e is CurrencyError) {
      return e;
    }
    return CurrencyError(
      errorCode: unknownCode,
      errorMessage: e.toString(),
    );
  }

  factory CurrencyError.timeout() => CurrencyError(
        errorCode: timeoutCode,
        errorMessage: strings.error_timeout,
      );

  factory CurrencyError.noInternet() => CurrencyError(
        errorCode: noInternetCode,
        errorMessage: strings.error_no_internet,
      );

  factory CurrencyError.serverError(
    int statusCode,
  ) =>
      CurrencyError(
        errorCode: serverCode,
        errorMessage: strings.error_server(
          statusCode,
        ),
      );

  factory CurrencyError.badResponse(
    int statusCode,
  ) =>
      CurrencyError(
        errorCode: badResponseCode,
        errorMessage: strings.error_bad_response(
          statusCode,
        ),
      );

  factory CurrencyError.cancelled() => CurrencyError(
        errorCode: cancelledCode,
        errorMessage: strings.error_cancelled,
      );

  factory CurrencyError.unknown() => CurrencyError(
        errorCode: unknownCode,
        errorMessage: strings.error_unknown,
      );

  factory CurrencyError.parsing() => CurrencyError(
        errorCode: parsingCode,
        errorMessage: strings.error_parsing,
      );

  factory CurrencyError.noData() => CurrencyError(
        errorCode: noDataCode,
        errorMessage: strings.error_no_data,
      );

  factory CurrencyError.loadFailed() => CurrencyError(
        errorCode: loadFailedCode,
        errorMessage: strings.error_load_failed,
      );
}
