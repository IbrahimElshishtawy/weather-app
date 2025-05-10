import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1/';
  String apiKey = '28e634beb3c440b694b151731250305'; // تأكد من صحته

  Future<void> getWeather({required String cityName}) async {
    Uri url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=$cityName&aqi=no');

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        Map<String, dynamic> weatherData = {
          'location': data['location'],
          'current': data['current'],
          // مفيش forecast هنا لأنك بتستخدم current.json
        };

        print(weatherData);
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
