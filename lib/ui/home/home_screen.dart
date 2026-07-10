import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../../models/day_weather.dart';
import '../../resources/colors/app_colors.dart';
import '../../resources/dimens/app_dimens.dart';
import '../../resources/images/app_images/app_images.dart';
import '../../utils/date_formatter.dart';
import '../common/map_widget/map_view_widget.dart';
import 'home_controller.dart';
import 'widgets/day_weather_item_widget.dart';

part 'home_screen.app_bar_state.part.dart';

part 'home_screen.error_state.part.dart';

part 'home_screen.load_state.part.dart';

part 'home_screen.map_overlay.part.dart';

part 'home_screen.success_state.part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _onRefreshPressed();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final homeController = _homeController;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight + AppDimens.appBarBottomHeight,
        ),
        child: Observer(
          builder: (_) {
            return _buildAppBarWidget(
              cityName: homeController.appBarCityName,
              lastUpdateDate: homeController.lastUpdateDate,
              onMapPressed: _showMapOverlay,
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefreshPressed,
        child: Stack(
          children: [
            Observer(
              builder: (_) {
                return Visibility(
                  visible: homeController.isLoading,
                  child: _buildLoadingWidget(),
                );
              },
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: homeController.hasError,
                  child: _buildErrorWidget(
                    errorMessage: homeController.error?.errorMessage,
                    onRetryPressed: _onRefreshPressed,
                  ),
                );
              },
            ),
            Observer(
              builder: (_) {
                final dayWeather = homeController.dayWeather;
                return Visibility(
                  visible: homeController.hasSuccess,
                  child: _buildSuccessWidget(
                    dayWeather: dayWeather,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMapOverlay() {
    showDialog(
      context: context,
      builder: (
        dialogContext,
      ) =>
          _buildMapOverlayWidget(
        latitude: _homeController.latitude,
        longitude: _homeController.longitude,
        onClose: () => Navigator.of(
          dialogContext,
        ).pop(),
      ),
    );
  }

  Future<void> _onRefreshPressed() async {
    await _homeController.onRefreshPressed();
  }
}
