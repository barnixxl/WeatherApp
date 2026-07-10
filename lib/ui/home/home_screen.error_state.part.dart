part of 'home_screen.dart';

Widget _buildErrorWidget({
  required String? errorMessage,
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
            AppImages.icErrorOutline,
            width: AppDimens.iconXl,
            height: AppDimens.iconXl,
            color: AppColors.error,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            errorMessage ?? strings.error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppDimens.fontMd,
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
