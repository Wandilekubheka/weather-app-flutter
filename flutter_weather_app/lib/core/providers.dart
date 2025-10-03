import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:flutter_weather_app/pages/modelview/weather_notifier.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((
  ref,
) {
  final weatherService = WeatherService();
  return WeatherNotifier(weatherService);
});
