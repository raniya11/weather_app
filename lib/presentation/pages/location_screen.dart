import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/pages/weather_screen.dart';
import '../../provider/weather_provider.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  LocationSelectionScreenState createState() => LocationSelectionScreenState();
}

class LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _cityController = TextEditingController();
  final List<String> predefinedCities = [
    'Delhi',
    'Bangalore',
    'Miami',
    'Calicut',
    'Mumbai',
    'Cochin',
    'Dubai',
    'Thrissur'
  ];
  String? selectedCity;

  void _fetchWeather(BuildContext context, String city) async {
    if (city.isEmpty) {
      _showErrorDialog(context, "Please enter or select a city!");
      return;
    }

    try {
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(city);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WeatherDisplayScreen()),
      );
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Center(child: Text('Error!')),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for a City'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Find Weather for Your Location',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // City Input
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter City Name',
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Predefined Cities
            const Text(
              'Or select from popular cities:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: predefinedCities.map((city) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCity = city;
                      _fetchWeather(context, city);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          selectedCity == city ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      city,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            selectedCity == city ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Search Button
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  _fetchWeather(context, city);
                } else {
                  _showErrorDialog(context, "Please enter a city!");
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Search Weather',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
