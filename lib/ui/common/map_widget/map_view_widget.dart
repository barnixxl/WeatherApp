import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../config/app_config.dart';
import '../../../../main.dart';
import '../../../../resources/colors/app_colors.dart';
import '../../../../resources/dimens/app_dimens.dart';
import '../../../../resources/images/map_images/map_images.dart';

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return RepaintBoundary(
      child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              key: ValueKey(
                '$latitude,'
                '$longitude,'
              ),
              options: MapOptions(
                initialCenter: LatLng(
                  latitude,
                  longitude,
                ),
                initialZoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: AppConfig.mapTileUrl,
                  userAgentPackageName: AppConfig.mapUserAgent,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        latitude,
                        longitude,
                      ),
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        MapImages.locationPin,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            strings.map_osm_attribution,
            style: const TextStyle(
              fontSize: AppDimens.fontXxs,
              color: AppColors.primaryGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
