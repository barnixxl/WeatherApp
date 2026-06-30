import 'package:flutter/material.dart';

import '../shared/app_card_widget.dart';
import 'map_header_widget.dart';
import 'weather_map_view_widget.dart';

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
    return AppCardWidget(
      height: 300,
      clipContent: true,
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
    );
  }
}
