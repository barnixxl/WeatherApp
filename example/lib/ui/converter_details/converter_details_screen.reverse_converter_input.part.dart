part of 'converter_details_screen.dart';

Widget _buildReverseConverterInputWidget({
  required FocusNode focusNode,
  required String sourceCurrencyCode,
  required void Function(
    String,
  ) onCurrencyAmountChanged,
}) {
  return TextField(
    focusNode: focusNode,
    onTapOutside: (_) {
      return focusNode.unfocus();
    },
    keyboardType: const TextInputType.numberWithOptions(
      decimal: true,
    ),
    decoration: InputDecoration(
      labelText: strings.amount_in(
        sourceCurrencyCode,
      ),
      border: const OutlineInputBorder(),
    ),
    onChanged: onCurrencyAmountChanged,
  );
}
