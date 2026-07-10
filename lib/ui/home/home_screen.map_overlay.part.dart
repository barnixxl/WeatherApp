part of 'home_screen.dart';

Widget _buildMapOverlayWidget({
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
        AppDimens.radiusMd,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildOverlayHeaderWidget(
          onClose,
        ),
        SizedBox(
          height: AppDimens.mapOverlayHeight,
          child: MapViewWidget(
            latitude: latitude,
            longitude: longitude,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverlayHeaderWidget(
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
          AppImages.icLocationOn,
          width: AppDimens.iconXs,
          height: AppDimens.iconXs,
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
              fontSize: AppDimens.fontSm,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: Image.asset(
            AppImages.icClose,
            width: AppDimens.iconSm,
            height: AppDimens.iconSm,
          ),
          onPressed: onClose,
        ),
      ],
    ),
  );
}
