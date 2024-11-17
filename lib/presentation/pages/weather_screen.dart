import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/weather_provider.dart';

class WeatherDisplayScreen extends StatelessWidget {
  const WeatherDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${weatherProvider.weather!.location!.name!} is ${weatherProvider.weather!.current!.condition!.text} Today! ',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
        // elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: weatherProvider.weather == null
          ? const Center(
              child: Text(
                'No weather data available.\nPlease go back and select a city.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // City Name
                  Text(
                    weatherProvider.weather!.location!.name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Icon
                  Image.network(
                    "https:${weatherProvider.weather!.current!.condition!.icon!}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weatherProvider.weather!.current!.condition!.text!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${weatherProvider.weather!.current!.tempC!.toStringAsFixed(1)}°C',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Weather Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _weatherDetail(
                        label: 'Wind',
                        value:
                            '${weatherProvider.weather!.current!.windKph} km/h',
                      ),
                      _weatherDetail(
                        label: 'Humidity',
                        value: '${weatherProvider.weather!.current!.humidity}%',
                      ),
                      _weatherDetail(
                        label: 'Pressure',
                        value:
                            '${weatherProvider.weather!.current!.pressureMb} mb',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // Widget for a weather detail
  Widget _weatherDetail({
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
