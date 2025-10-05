import 'package:flutter_weather_app/data/models/weather_data.dart';

abstract class WeatherRepository {
  Future<List<WeatherData>> getWeather();
  Future<void> addWeather(WeatherData weather);
  Future<void> deleteWeather(String cityName);
}
