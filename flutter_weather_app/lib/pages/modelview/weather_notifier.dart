import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:flutter_weather_app/domain/repository/weather_repository.dart';
import 'package:location/location.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherService _weatherService;
  final WeatherRepository _repository;
  final location = Location();

  WeatherNotifier(this._weatherService, this._repository)
    : super(WeatherState.initial()) {
    getUserLocation();
  }

  void getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      locationData = await location.getLocation().timeout(Duration(seconds: 3));
      await fetchWeather(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      await fetchWeather(0, 0);
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final weatherData = await _weatherService.fetchWeather(lat, lon);
      await _repository.addWeather(weatherData);
      state = state.copyWith(isLoading: false, weatherData: weatherData);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> overrideHomeScreenData(WeatherData data) async {
    state = state.copyWith(weatherData: data);
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
