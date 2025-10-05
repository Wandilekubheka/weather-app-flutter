import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/providers.dart';
import 'package:flutter_weather_app/data/models/weather_data.dart';

class AddLocation extends ConsumerStatefulWidget {
  const AddLocation({super.key});

  @override
  ConsumerState<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends ConsumerState<AddLocation> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(addWeatherProvider);
    final addWeatherNotifier = ref.read(addWeatherProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: BackButtonIcon(),
        ),
        title: Text("Add Location", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search city",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white12,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await addWeatherNotifier.fetchWeatherByCity(
                          _searchController.text,
                        );
                        if (weatherState.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error: ${weatherState.error}"),
                            ),
                          );
                        }
                        _searchController.clear();
                      },
                      icon: Icon(Icons.search, color: Colors.white54),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {},
                ),
                // _searchField(),
                SizedBox(height: 20),

                if (weatherState.isLoading)
                  Center(child: CircularProgressIndicator()),

                if (weatherState.weatherList.isNotEmpty)
                  knownWeatherList(weatherState.weatherList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget knownWeatherList(List<WeatherData> weatherList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: weatherList.length,
      itemBuilder: (context, index) {
        final weatherData = weatherList[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: GestureDetector(
            onTap: () async {
              await ref
                  .read(weatherProvider.notifier)
                  .overrideHomeScreenData(weatherData);
              Navigator.pop(context);
            },
            onLongPress: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Delete Location"),
                    content: Text(
                      "Are you sure you want to delete ${weatherData.cityName}?",
                    ),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          ref
                              .read(addWeatherProvider.notifier)
                              .removeLocation(weatherData.cityName);
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 20.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${weatherData.temperature}°',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              weatherData.cityName,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              weatherData.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      height: 1.0,
                      color: Colors.white24,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cloud, color: Colors.white54),
                            const SizedBox(width: 5),
                            Text(
                              "${weatherData.rainChance}%",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Icon(Icons.wind_power, color: Colors.white54),
                            const SizedBox(width: 5),
                            Text(
                              "${weatherData.windSpeed} km/h",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Icon(Icons.water_drop, color: Colors.white54),
                            const SizedBox(width: 5),
                            Text(
                              "${weatherData.humidity}%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
