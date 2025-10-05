import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String apiKey = dotenv.env['WEATHER_API'] ?? '';

  Future<WeatherData> fetchWeather(double lat, double lon) async {
    if (apiKey.isEmpty) {
      throw Exception("API key is missing. Please set it in the .env file.");
    }

    String apiURL =
        'https://api.weatherbit.io/v2.0/current?lat=$lat&lon=$lon&key=$apiKey&include=minutely';
    try {
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        return WeatherData.fromJsonAPI(
          Map<String, dynamic>.from(jsonDecode(response.body)),
        );
      } else {
        throw HttpException(
          'Failed to load weather data: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  Future<WeatherData> fetchWeatherByCity(String city) async {
    if (apiKey.isEmpty) {
      throw Exception("API key is missing. Please set it in the .env file.");
    }

    String apiURL =
        'https://api.weatherbit.io/v2.0/current?city=$city&key=$apiKey&include=minutely';
    try {
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        return WeatherData.fromJsonAPI(
          Map<String, dynamic>.from(jsonDecode(response.body)),
        );
      } else {
        throw HttpException(
          'Failed to load weather data: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
