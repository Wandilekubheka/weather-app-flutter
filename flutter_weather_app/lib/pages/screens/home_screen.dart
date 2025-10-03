import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                Text(
                  "About Today",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Container(height: 200, width: 200, color: Colors.white24),
                const SizedBox(height: 20),
                const Text("Friday , 20 Jan"),
                Text("7°", style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _weather_detail_card(),
                    _weather_detail_card(),
                    _weather_detail_card(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weather_detail_card() {
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
          Container(height: 40, width: 40, color: Colors.white54),
          const SizedBox(height: 10),
          Text("Now", style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),

          Text("7°", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
