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
          child: MapView(
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
        Expanded(
          child: Text(
            strings.current_location,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.onPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
