class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int rainChance;
  double latitude;
  double longitude;
  String countryCode;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.rainChance,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
  });
  factory WeatherData.fromJsonAPI(Map<String, dynamic> json) {
    final data = json['data'][0];
    print(data);
    return WeatherData(
      cityName: data['city_name'] ?? '',
      temperature: (data['temp'] ?? 0).toDouble(),
      description: data['weather']?['description'] ?? 'N/A',
      humidity: data['rh'] ?? 0,
      windSpeed: (data['wind_speed'] ?? 0).toDouble(),
      rainChance: (data['precip'] ?? 0).toInt(),
      latitude: (data['lat'] ?? 0).toDouble(),
      longitude: (data['lon'] ?? 0).toDouble(),
      countryCode: data['country_code'] ?? 'N/A',
    );
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['cityName'] ?? '',
      temperature: (json['temperature'] ?? 0).toDouble(),
      description: json['description'] ?? 'N/A',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['windSpeed'] ?? 0).toDouble(),
      rainChance: (json['rainChance'] ?? 0).toInt(),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      countryCode: json['countryCode'] ?? 'N/A',
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
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    };
  }
}
