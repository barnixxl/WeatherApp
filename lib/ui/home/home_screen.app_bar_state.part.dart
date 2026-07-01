part of 'home_screen.dart';

Widget _buildAppBarWidget({
  required String cityName,
  required DateTime? firstForecastDate,
}) {
  return AppBar(
    title: Text(
      strings.home_title,
    ),
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
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
                firstForecastDate?.toDayMonthYearTextDateFormat() ??
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
