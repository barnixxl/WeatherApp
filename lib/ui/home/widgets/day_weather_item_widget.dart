import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/hour_weather.dart';
import '../../../resources/colors/app_colors.dart';
import '../../../resources/dimens/app_dimens.dart';
import '../../../utils/date_formatter.dart';
import '../../common/app_card/app_card_widget.dart';
import 'hourly_weather_row.dart';

class DayWeatherItem extends StatelessWidget {
  final DateTime date;
  final double dayMinTemp;
  final double dayMaxTemp;
  final List<HourWeather> hourlyData;

  const DayWeatherItem({
    super.key,
    required this.date,
    required this.dayMinTemp,
    required this.dayMaxTemp,
    required this.hourlyData,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                date.toDayOfWeekFormat() ?? strings.common_absent_day,
                style: const TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: AppDimens.fontLg,
                ),
              ),
              const Spacer(),
              Text(
                strings.temperature_range(
                  dayMinTemp.toStringAsFixed(
                    0,
                  ),
                  dayMaxTemp.toStringAsFixed(
                    0,
                  ),
                ),
                style: const TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: AppDimens.fontMd,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          HourlyWeatherRow(
            hourlyData: hourlyData,
          ),
        ],
      ),
    );
  }
}
