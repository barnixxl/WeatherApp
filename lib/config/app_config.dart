import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String? get apiKey => dotenv.env['WEATHER_API_KEY'];
  static const mapTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const mapUserAgent = 'com.misabirin.weatherApp';
  static const language = 'ru';
  static const units = 'metric';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/';
}
