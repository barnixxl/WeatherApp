part of 'home_screen.dart';

Widget _buildMapOverlay({
  required double latitude,
  required double longitude,
  required void Function() onClose,
}) {
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
        _buildOverlayHeader(
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

Widget _buildOverlayHeader(
  void Function() onClose,
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
