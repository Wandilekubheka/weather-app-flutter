import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _weatherState = ref.watch(weatherProvider);

    if (_weatherState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_weatherState.error != null) {
      return Scaffold(
        body: Center(child: Text("Error: ${_weatherState.error}")),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Oakdene, ZA",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white54,
                    ),
                  ],
                ),
                // header content
                // Main content
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "About Today",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset("assets/icons/storm.png", height: 200),
                const SizedBox(height: 20),
                Text(formatDate(DateTime.now())),
                Text(
                  "${_weatherState.weatherData!.temperature}°",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _weather_detail_card(
                      "Rain",
                      "${_weatherState.weatherData!.rainChance}%",
                      "storm",
                    ),
                    _weather_detail_card(
                      "Wind",
                      "${_weatherState.weatherData!.windSpeed} km/h",
                      "wind",
                    ),
                    _weather_detail_card(
                      "Humidity",
                      "${_weatherState.weatherData!.humidity}%",
                      "humidity",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weather_detail_card(String title, String content, String iconName) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        color: Colors.white24,
      ),
      height: 130,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            child: Image.asset('assets/icons/$iconName.png'),
          ),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),

          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    final months = [
      //abbr
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final month = months[date.month - 1];
    final day = date.day;
    final dayOfWeek = weekdays[date.weekday - 1];
    final year = date.year;
    return '$dayOfWeek, $day $month';
  }
}
