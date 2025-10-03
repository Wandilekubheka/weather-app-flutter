class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int rainChance;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.rainChance,
  });
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final data = json['data'][0];

    return WeatherData(
      cityName: data['city_name'] ?? '',
      temperature: (data['temp'] ?? 0).toDouble(),
      description: data['weather']?['description'] ?? 'N/A',
      humidity: data['rh'] ?? 0,
      windSpeed: (data['wind_speed'] ?? 0).toDouble(),
      rainChance: (data['precip'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'description': description,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'rainChance': rainChance,
    };
  }
}
