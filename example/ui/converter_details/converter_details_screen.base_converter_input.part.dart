part of 'converter_details_screen.dart';

Widget _buildBaseConverterInputWidget({
  required FocusNode focusNode,
  required void Function(
    String,
  ) onBaseAmountChanged,
}) {
  return TextField(
    focusNode: focusNode,
    onTapOutside: (_) => focusNode.unfocus(),
    keyboardType: const TextInputType.numberWithOptions(
      decimal: true,
    ),
    decoration: InputDecoration(
      labelText: strings.amount_in(
        strings.base_cur_code,
      ),
      border: const OutlineInputBorder(),
    ),
    onChanged: onBaseAmountChanged,
  );
}
