part of 'home_screen.dart';

Widget _buildLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 16,
        ),
        Text(
          strings.loading_currencies,
        ),
      ],
    ),
  );
}
