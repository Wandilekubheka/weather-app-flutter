import 'package:flutter_weather_app/data/models/app_database.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';
import 'package:flutter_weather_app/domain/repository/weather_repository.dart';
import 'package:sqflite/sqflite.dart';

class ImpWeatherRepository implements WeatherRepository {
  final AppDatabase _appDatabase;
  ImpWeatherRepository(this._appDatabase);
  @override
  Future<List<WeatherData>> getWeather() async {
    final db = await _appDatabase.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('weather');
    return maps.map((weather) => WeatherData.fromJson(weather)).toList();
  }

  @override
  Future<void> addWeather(WeatherData weather) async {
    try {
      final db = await _appDatabase.getDatabase();
      await db.insert(
        'weather',
        weather.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e.toString());
      throw FormatException('an error occur while trying to add weather data');
    }
  }

  @override
  Future<void> deleteWeather(String cityName) async {
    try {
      final db = await _appDatabase.getDatabase();
      await db.delete('weather', where: 'cityName = ?', whereArgs: [cityName]);
    } catch (e) {
      throw FormatException(
        'an error occur while trying to delete weather data',
      );
    }
  }
}
