import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../../models/currency_error.dart';
import '../../models/rate_data.dart';
import '../../resources/colors/app_colors.dart';
import '../../utils/date_formatter.dart';
import '../converter_details/converter_details_screen.dart';
import 'home_controller.dart';
import 'widgets/currency_list_item.dart';

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
    _loadData();
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
              lastUpdateDate: homeController.lastUpdateDate,
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
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
                    onRetryPressed: _loadData,
                  ),
                );
              },
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: homeController.hasSuccess,
                  child: _buildSuccessWidget(
                    currencies: homeController.currencies,
                    onCurrencyPressed: _navigateToDetail,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  void _navigateToDetail(
    RateData currency,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return ConverterDetailsScreen(
            currency: currency,
          );
        },
      ),
    );
  }
}
