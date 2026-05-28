import 'package:mobx/mobx.dart';

import '../../models/rate_data.dart';

class ConverterDetailsController {
  final Observable<RateData?> _rateData = Observable(
    null,
  );

  final Observable<String> _baseAmountInput = Observable(
    '',
  );

  final Observable<String> _currencyAmountInput = Observable(
    '',
  );

  String get code => _rateData.value?.code ?? '';

  String get name => _rateData.value?.name ?? '';

  DateTime? get date => _rateData.value?.date;

  double get rate => _rateData.value?.rate ?? 0.0;

  int get scale => _rateData.value?.scale ?? 1;

  bool get hasBaseAmount => _baseAmountInput.value.isNotEmpty;

  bool get hasCurrencyAmount => _currencyAmountInput.value.isNotEmpty;

  String get convertedAmount => _calculateConvertedAmount();

  String get convertedAmountReverse => _calculateConvertedAmountReverse();

  void onBaseAmountChanged(
    String value,
  ) {
    runInAction(() {
      _baseAmountInput.value = value;
    });
  }

  void onCurrencyAmountChanged(
    String value,
  ) {
    runInAction(() {
      _currencyAmountInput.value = value;
    });
  }

  void loadCurrency(
    RateData rateData,
  ) {
    runInAction(() {
      _rateData.value = rateData;
    });
  }

  double _parseAmount(
    String input,
  ) =>
      double.tryParse(
        input.replaceAll(
          ',',
          '.',
        ),
      ) ??
      0.0;

  String _calculateConvertedAmount() {
    final amount = _parseAmount(
      _baseAmountInput.value,
    );
    return _calculateForward(
      amount,
    );
  }

  String _calculateConvertedAmountReverse() {
    final amount = _parseAmount(
      _currencyAmountInput.value,
    );
    return _calculateReverse(
      amount,
    );
  }

  String _calculateForward(
    double amount,
  ) {
    final rateValue = rate != 0 ? rate : 1;
    return (amount * scale / rateValue).toStringAsFixed(
      2,
    );
  }

  String _calculateReverse(
    double amount,
  ) {
    final scaleValue = scale != 0 ? scale : 1;
    return (amount * rate / scaleValue).toStringAsFixed(
      2,
    );
  }
}
