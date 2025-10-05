import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_weather_app/data/models/app_database.dart';
import 'package:flutter_weather_app/data/repository/weather_repository.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:flutter_weather_app/pages/modelview/add_weather_notifier.dart';
import 'package:flutter_weather_app/pages/modelview/weather_notifier.dart';

final weatherRepository = ImpWeatherRepository(AppDatabase.instance);
final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((
  ref,
) {
  final weatherService = WeatherService();
  return WeatherNotifier(weatherService, weatherRepository);
});

final addWeatherProvider =
    StateNotifierProvider<AddWeatherNotifier, AddWeatherState>((ref) {
      final weatherService = WeatherService();
      return AddWeatherNotifier(weatherRepository, weatherService);
    });
