import 'package:flutter_weather_app/data/models/weather_data.dart';

class WeatherService {
  Future<WeatherData> fetchWeather(String city) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Return mock data
    return WeatherData(
      cityName: city,
      temperature: 22.5,
      description: "Partly Cloudy",
      humidity: 60,
      windSpeed: 5.5,
      rainChance: 10,
    );
  }
}
