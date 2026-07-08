part of 'home_screen.dart';

Widget _buildAppBarWidget({
  required String cityName,
  required DateTime? lastUpdateDate,
  required void Function() onMapPressed,
}) {
  return AppBar(
    title: Text(
      strings.home_title,
    ),
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    actions: [
      IconButton(
        icon: Image.asset(
          MapImages.mapIcon,
          width: 24,
          height: 24,
        ),
        onPressed: onMapPressed,
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(
        40,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        color: AppColors.primaryDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              strings.app_bar_subtitle(
                cityName,
                lastUpdateDate?.toDayMonthYearTextDateFormat() ??
                    strings.common_absent_date,
              ),
              style: const TextStyle(
                color: AppColors.onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
