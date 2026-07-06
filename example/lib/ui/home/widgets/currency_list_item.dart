import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/rate_data.dart';
import '../../../repository/currency_repository.dart';
import '../../../resources/colors/app_colors.dart';

class CurrencyListItem extends StatelessWidget {
  final RateData currency;
  final void Function(
    RateData,
  ) onTap;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(
          16,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(
              alpha: 0.3,
            ),
            blurRadius: 4,
            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      ),
      child: ListTile(
        textColor: AppColors.onPrimary,
        leading: Image.asset(
          CurrencyAssets.fromCode(
            currency.code,
          ).imagePath,
          width: 40,
          height: 40,
        ),
        title: Text(
          currency.name,
        ),
        subtitle: Text(
          strings.common_scale_equals_rate_byn(
            currency.scale,
            currency.code,
            currency.rate.toStringAsFixed(
              2,
            ),
          ),
        ),
        onTap: () {
          onTap(
            currency,
          );
        },
      ),
    );
  }
}
