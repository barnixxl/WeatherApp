import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../../models/day_weather.dart';
import '../../models/weather_error.dart';
import '../../resources/colors/app_colors.dart';
import '../../utils/date_formatter.dart';
import 'home_controller.dart';
import 'widgets/day_weather_item.dart';
import 'widgets/weather_map_widget.dart';

part 'home_screen.app_bar_state.part.dart';
part 'home_screen.error_state.part.dart';
part 'home_screen.load_state.part.dart';
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
          kToolbarHeight + 40,
        ),
        child: Observer(
          builder: (_) {
            return _buildAppBarWidget(
              cityName: homeController.cityName,
              lastUpdateDate: homeController.lastUpdateDate,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
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
                          error: homeController.error,
                          onRetryPressed: _onRefreshPressed,
                        ),
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return Visibility(
                        visible: homeController.hasSuccess,
                        child: _buildSuccessWidget(
                          dayWeather: homeController.dayWeather,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: homeController.hasSuccess,
                child: WeatherMapWidget(
                  latitude: homeController.latitude,
                  longitude: homeController.longitude,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onRefreshPressed() async {
    await _homeController.onRefreshPressed();
  }
}
