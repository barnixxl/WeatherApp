part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<RateData> currencies,
  required void Function(
    RateData,
  ) onCurrencyPressed,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(
      8,
    ),
    itemCount: currencies.length,
    itemBuilder: (
      context,
      index,
    ) {
      final currency = currencies[index];
      return CurrencyListItem(
        currency: currency,
        onTap: onCurrencyPressed,
      );
    },
  );
}
