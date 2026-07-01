part of 'home_screen.dart';

Widget _buildErrorWidget({
  required WeatherError? error,
  required void Function() onRetryPressed,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MapImages.errorOutline,
            width: 64,
            height: 64,
            color: AppColors.error,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            error?.errorMessage ?? strings.error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: onRetryPressed,
            child: Text(
              strings.retry,
            ),
          ),
        ],
      ),
    ),
  );
}
