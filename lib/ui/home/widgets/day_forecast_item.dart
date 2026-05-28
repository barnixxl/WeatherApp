import 'package:flutter/material.dart';

import '../../../models/day_forecast.dart';
import '../../../resources/colors/app_colors.dart';
import '../../../utils/date_formatter.dart';
import 'hourly_forecast_row.dart';

class DayForecastItem extends StatelessWidget {
  final DayForecast forecast;

  const DayForecastItem({
    super.key,
    required this.forecast,
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
      child: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forecast.date.toDayOfWeekFormat() ?? '',
              style: const TextStyle(
                color: AppColors.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            HourlyForecastRow(
              hourlyData: forecast.hourlyData,
            ),
          ],
        ),
      ),
    );
  }
}
