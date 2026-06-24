import 'package:flutter/material.dart';

import '../../../../resources/colors/app_colors.dart';
import 'map_header_widget.dart';
import 'weather_map_view.dart';

class WeatherMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  const WeatherMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
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
      height: 300,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          16,
        ),
        child: Column(
          children: [
            const MapHeaderWidget(),
            Expanded(
              child: WeatherMapView(
                latitude: latitude,
                longitude: longitude,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
