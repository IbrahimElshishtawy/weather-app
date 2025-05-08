import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  void getWeather({required String cityName, required String apiKey}) async {
    // Simulate a network call to fetch weather data
    // You can replace this with your actual API call
    // For example, using the http package to make a GET request
    String baseUrl = 'http://api.weatherapi.com/v1/';
    String apiKey = '28e634beb3c440b694b151731250305';
    Uri url = Uri.parse(
      '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7&aqi=no&alerts=no',
    );
    http.Response response = await http.get(url);
    // await Future.delayed(const Duration(seconds: 2));
    response.body; // This will be the JSON data from the API
    dynamic data = jsonDecode(response.body); // Decode the JSON data
    Map<String, dynamic> weatherData = {
      'location': data['location'],
      'current': data['current'],
      'forecast': data['forecast'],
    };
    // Process the weather data as needed
    print(weatherData['location']['name']); // Example: Print the location name
    print(
      weatherData['current']['temp_c'],
    ); // Example: Print the current temperature
    print(
      weatherData['forecast']['forecastday'][0]['day']['condition']['text'],
    ); // Example: Print the weather condition
    print(
      weatherData['forecast']['forecastday'][0]['day']['maxtemp_c'],
    ); // Example: Print the max temperature
    print(
      weatherData['forecast']['forecastday'][0]['day']['mintemp_c'],
    ); // Example: Print the min temperature
  }
}
