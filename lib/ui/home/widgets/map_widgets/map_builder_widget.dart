import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../resources/colors/app_colors.dart';
import '../../../../resources/images/map_images/map_images.dart';
import 'map_view_widget.dart';

class MapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final VoidCallback onClose;

  const MapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onClose,
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
          _buildHeader(
            context,
            onClose,
          ),
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

Widget _buildHeader(
  BuildContext context,
  VoidCallback onClose,
) {
  return Container(
    padding: const EdgeInsets.all(
      12,
    ),
    color: AppColors.primaryDark,
    child: Row(
      children: [
        Image.asset(
          MapImages.locationOn,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          strings.current_location,
          style: const TextStyle(
            color: AppColors.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Image.asset(
            MapImages.closeIcon,
            width: 24,
            height: 24,
          ),
          onPressed: onClose,
        ),
      ],
    ),
  );
}
