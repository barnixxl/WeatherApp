import 'package:get_it/get_it.dart';

import '../../models/currency_error.dart';
import '../../models/currency_result.dart';
import '../../models/rate_data.dart';
import '../currency_rate_network.dart';
import 'resp/rate_data_from_network.dart';

class CurrencyApi {
  static final GetIt _getIt = GetIt.instance;

  late final CurrencyRateNetwork _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<CurrencyApi>(
      this,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<CurrencyRateNetwork>();
  }

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    const url = '/rates?periodicity=0';
    try {
      final result = await _network.get(
        url,
      );
      if (result.error == null) {
        final networkRates = (result.data as List<dynamic>)
            .map((e) => RateDataFromNetwork.fromJson(
                  e as Map<String, dynamic>,
                ))
            .toList();
        final rates =
            networkRates.map((e) => RateData.fromNetworkModel(e)).toList();
        return CurrencyResult.success(
          rates,
        );
      } else {
        return CurrencyResult.failure(
          result.error,
        );
      }
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
