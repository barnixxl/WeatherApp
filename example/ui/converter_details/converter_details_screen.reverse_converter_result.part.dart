part of 'converter_details_screen.dart';

Widget _buildReverseConverterResultWidget({
  required String convertedResult,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 8,
        ),
        child: Text(
          strings.converted_result_reverse(
            convertedResult,
            strings.base_currency_name,
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}
