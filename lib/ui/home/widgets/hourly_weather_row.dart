import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/weather_data.dart';
import '../../../resources/colors/app_colors.dart';
import '../../../utils/date_formatter.dart';
import '../../../resources/images/app_images.dart';

class HourlyWeatherRow extends StatelessWidget {
  final List<WeatherData> hourlyData;

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
                Icon(
                  AppImages.getIcon(
                    weather.weatherIcon,
                  ),
                  color: AppColors.onPrimary,
                  size: 32,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  weather.dateTime.toHourMinuteFormat() ?? '',
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  strings.temperature_format(weather.temperature.toStringAsFixed(0)),
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 16,
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
