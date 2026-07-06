import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../../models/rate_data.dart';
import '../../repository/currency_repository.dart';
import '../../resources/colors/app_colors.dart';
import '../../utils/date_formatter.dart';
import 'converter_details_controller.dart';

part 'converter_details_screen.base_converter_input.part.dart';
part 'converter_details_screen.base_converter_result.part.dart';
part 'converter_details_screen.header.part.dart';
part 'converter_details_screen.reverse_converter_input.part.dart';
part 'converter_details_screen.reverse_converter_result.part.dart';

class ConverterDetailsScreen extends StatefulWidget {
  final RateData currency;

  const ConverterDetailsScreen({
    super.key,
    required this.currency,
  });

  @override
  State<ConverterDetailsScreen> createState() => _ConverterDetailsScreenState();
}

class _ConverterDetailsScreenState extends State<ConverterDetailsScreen> {
  final ConverterDetailsController _controller = ConverterDetailsController();
  final FocusNode _baseInputFocusNode = FocusNode();
  final FocusNode _currencyInputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.loadCurrency(
      widget.currency,
    );
  }

  @override
  void dispose() {
    _baseInputFocusNode.dispose();
    _currencyInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _controller.code,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderWidget(
              code: _controller.code,
              name: _controller.name,
              rate: _controller.rate,
              scale: _controller.scale,
              date: _controller.date,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(
                  builder: (_) {
                    final hasBaseAmount = _controller.hasBaseAmount;
                    final convertedAmount = _controller.convertedAmount;
                    final name = _controller.name;
                    final code = _controller.code;
                    return Visibility(
                      visible: hasBaseAmount,
                      child: _buildBaseConverterResultWidget(
                        convertedResult: convertedAmount,
                        resultCurrencyName: name,
                        resultCurrencyCode: code,
                      ),
                    );
                  },
                ),
                _buildBaseConverterInputWidget(
                  focusNode: _baseInputFocusNode,
                  onBaseAmountChanged: _controller.onBaseAmountChanged,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(
                  builder: (_) {
                    final hasCurrencyAmount = _controller.hasCurrencyAmount;
                    final convertedAmountReverse =
                        _controller.convertedAmountReverse;
                    return Visibility(
                      visible: hasCurrencyAmount,
                      child: _buildReverseConverterResultWidget(
                        convertedResult: convertedAmountReverse,
                      ),
                    );
                  },
                ),
                _buildReverseConverterInputWidget(
                  focusNode: _currencyInputFocusNode,
                  sourceCurrencyCode: _controller.code,
                  onCurrencyAmountChanged: _controller.onCurrencyAmountChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
