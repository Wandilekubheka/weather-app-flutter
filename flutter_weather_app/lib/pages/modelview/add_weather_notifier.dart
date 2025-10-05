import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:flutter_weather_app/domain/repository/weather_repository.dart';

class AddWeatherNotifier extends StateNotifier<AddWeatherState> {
  final WeatherRepository weatherRepository;
  final WeatherService weatherService;
  AddWeatherNotifier(this.weatherRepository, this.weatherService)
    : super(AddWeatherState()) {
    loadWeatherList();
  }

  Future<void> addLocation(double lat, double lon) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final weatherData = await weatherService.fetchWeather(lat, lon);
      await weatherRepository.addWeather(weatherData);

      state = state.copyWith(
        isLoading: false,
        weatherData: weatherData,
        weatherList: [...state.weatherList, weatherData],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadWeatherList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final weatherList = await weatherRepository.getWeather();
      state = state.copyWith(isLoading: false, weatherList: weatherList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final weatherData = await weatherService.fetchWeatherByCity(city);
      await weatherRepository.addWeather(weatherData);
      state = state.copyWith(
        isLoading: false,
        weatherData: weatherData,
        weatherList: await weatherRepository.getWeather(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateAllWeather() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedList = <WeatherData>[];
      for (var data in state.weatherList) {
        final updatedData = await weatherService.fetchWeather(
          data.latitude,
          data.longitude,
        );
        await weatherRepository.addWeather(updatedData);
        updatedList.add(updatedData);
      }
      state = state.copyWith(isLoading: false, weatherList: updatedList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeLocation(String cityName) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await weatherRepository.deleteWeather(cityName);
      final updatedList = state.weatherList
          .where((data) => data.cityName != cityName)
          .toList();
      state = state.copyWith(isLoading: false, weatherList: updatedList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class AddWeatherState {
  final bool isLoading;
  final String? error;
  final WeatherData? weatherData;
  final List<WeatherData> weatherList;

  AddWeatherState({
    this.isLoading = false,
    this.error,
    this.weatherData,
    this.weatherList = const [],
  });

  AddWeatherState copyWith({
    bool? isLoading,
    String? error,
    WeatherData? weatherData,
    List<WeatherData>? weatherList,
  }) {
    return AddWeatherState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      weatherData: weatherData ?? this.weatherData,
      weatherList: weatherList ?? this.weatherList,
    );
  }
}
