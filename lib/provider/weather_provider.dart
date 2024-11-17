import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant/constants.dart';
import '../model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  // static const String _apiKey = "6e58581f00284e2f95691656241611";
  // static const String _baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<void> fetchWeather(String city) async {
    final Uri uri = Uri.parse("$baseUrl?key=$apiKey&q=$city&aqi=no");

    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json['location'] == null || json['current'] == null) {
          throw Exception("Invalid response data");
        }
        _weather = WeatherModel.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Enter a valid city name");
      } else {
        throw Exception("Failed to fetch weather: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
