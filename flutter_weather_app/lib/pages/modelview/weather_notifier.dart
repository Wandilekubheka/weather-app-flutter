import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherService _weatherService;
  WeatherNotifier(this._weatherService) : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final weatherData = await _weatherService.fetchWeather(city);
      state = state.copyWith(isLoading: false, weatherData: weatherData);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class WeatherState {
  final bool isLoading;
  final String? error;
  final WeatherData? weatherData;
  WeatherState({this.isLoading = false, this.error, this.weatherData});
  WeatherState copyWith({
    bool? isLoading,
    String? error,
    WeatherData? weatherData,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      weatherData: weatherData ?? this.weatherData,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(isLoading: false, error: null, weatherData: null);
  }
}
