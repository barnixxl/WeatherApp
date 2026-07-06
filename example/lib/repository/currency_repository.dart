import 'package:get_it/get_it.dart';

import '../models/currency_result.dart';
import '../models/rate_data.dart';
import '../network/currency/currency_api.dart';
import '../repository/base_repository.dart';
import '../resources/images/app_images.dart';

class CurrencyRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;

  late final CurrencyApi _api;

  @override
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<CurrencyRepository>(
      this,
    );
  }

  @override
  Future<void> initializeDependencies() async {
    _api = _getIt<CurrencyApi>();
  }

  static CurrencyRepository getInstance() {
    return _getIt<CurrencyRepository>();
  }

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();
    if (result.isError) {
      return result;
    }
    return CurrencyResult.success(
      _filterAndSortRates(
        result.data,
      ),
    );
  }

  List<RateData> _filterAndSortRates(List<RateData>? rates) {
    if (rates != null) {
      const currencies = CurrencyAssets.values;
      final filtered = rates
          .where((r) => currencies.any((c) => c.name.toUpperCase() == r.code))
          .toList();
      filtered.sort((
        a,
        b,
      ) {
        final indexA =
            currencies.indexWhere((c) => c.name.toUpperCase() == a.code);
        final indexB =
            currencies.indexWhere((c) => c.name.toUpperCase() == b.code);
        return indexA.compareTo(
          indexB,
        );
      });
      return filtered;
    }
    return [];
  }
}

enum CurrencyAssets {
  usd,
  eur,
  cny,
  pln,
  uah;

  String get imagePath {
    switch (this) {
      case CurrencyAssets.usd:
        return AppImages.usd;
      case CurrencyAssets.eur:
        return AppImages.eur;
      case CurrencyAssets.cny:
        return AppImages.cny;
      case CurrencyAssets.pln:
        return AppImages.pln;
      case CurrencyAssets.uah:
        return AppImages.uah;
    }
  }

  static CurrencyAssets fromCode(
    String code,
  ) {
    switch (code) {
      case 'USD':
        return CurrencyAssets.usd;
      case 'EUR':
        return CurrencyAssets.eur;
      case 'CNY':
        return CurrencyAssets.cny;
      case 'PLN':
        return CurrencyAssets.pln;
      case 'UAH':
        return CurrencyAssets.uah;
      default:
        return CurrencyAssets.usd;
    }
  }
}
