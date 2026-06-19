import 'package:flutter/material.dart';

class AppIcons {
  static const String _basePath = 'assets/images/weather_state_images';

  static Image icon(
    String iconCode, {
    double? width,
    double? height,
  }) {
    return Image.asset(
      '$_basePath/$iconCode.png',
      width: width,
      height: height,
    );
  }
}
