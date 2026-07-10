import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/hour_weather.dart';
import '../../../resources/colors/app_colors.dart';
import '../../../resources/dimens/app_dimens.dart';
import '../../../utils/date_formatter.dart';

class HourlyWeatherRow extends StatelessWidget {
  final List<HourWeather> hourlyData;

  const HourlyWeatherRow({
    super.key,
    required this.hourlyData,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyData.length,
        itemBuilder: (
          context,
          index,
        ) {
          final weather = hourlyData[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(
              right: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  weather.weatherState.imagePath,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  weather.dateTime?.toHourMinuteFormat() ??
                      strings.common_absent_time,
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: AppDimens.fontXs,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  strings
                      .temperature_format(weather.temperature.toStringAsFixed(
                    0,
                  )),
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: AppDimens.fontMd,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
