import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../resources/colors/app_colors.dart';
import '../../../../resources/images/map_images/map_images.dart';

class MapHeaderWidget extends StatelessWidget {
  const MapHeaderWidget({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
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
            onPressed: () => Navigator.of(
              context,
            ).pop(),
          ),
        ],
      ),
    );
  }
}
