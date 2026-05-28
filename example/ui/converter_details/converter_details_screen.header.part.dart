part of 'converter_details_screen.dart';

Widget _buildHeaderWidget({
  required String code,
  required String name,
  required double rate,
  required int scale,
  required DateTime? date,
}) {
  final exchangeRateText = strings.common_scale_equals_rate_byn(
    scale,
    code,
    rate.toStringAsFixed(
      2,
    ),
  );
  final formattedDate = date?.toDayMonthYearTextDateFormat() ?? '';
  final hasValidDate = formattedDate.isNotEmpty;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            24,
          ),
          child: Column(
            children: [
              Image.asset(
                CurrencyAssets.fromCode(
                  code,
                ).imagePath,
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 32,
                color: AppColors.onPrimarySubtle,
              ),
              _buildInfoRow(
                label: strings.exchange_rate,
                value: exchangeRateText,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInfoRow(
                label: strings.base_currency,
                value: strings.base_currency_name,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInfoRow(
                label: strings.update_date,
                value:
                    hasValidDate ? formattedDate : strings.common_absent_date,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}

Widget _buildInfoRow({
  required String label,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.onPrimarySubtle,
          ),
        ),
      ),
      Flexible(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.onPrimary,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
