import 'package:flutter/material.dart';

import 'map_header_widget.dart';
import 'weather_map_view_widget.dart';

class MapOverlayWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapOverlayWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      insetPadding: const EdgeInsets.all(
        16,
      ),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MapHeaderWidget(),
          SizedBox(
            height: 300,
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
