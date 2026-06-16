import 'package:flutter/material.dart';

import '../../../models/day_weather.dart';
import '../../../resources/colors/app_colors.dart';
import '../../../utils/date_formatter.dart';
import 'hourly_weather_row.dart';

class DayWeatherItem extends StatelessWidget {
  final DayWeather dayWeather;

  const DayWeatherItem({
    super.key,
    required this.dayWeather,
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
            Row(
              children: [
                Text(
                  dayWeather.date.toDayOfWeekFormat() ?? '',
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${dayWeather.dayMinTemp.toStringAsFixed(0)}° - ${dayWeather.dayMaxTemp.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            HourlyWeatherRow(
              hourlyData: dayWeather.hourlyData,
            ),
          ],
        ),
      ),
    );
  }
}
