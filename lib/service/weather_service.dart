import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weathermodel.dart';
import 'package:flutter/foundation.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'c73a87393a5f4fe5b2b121122251605'; // تأكد من صلاحية المفتاح

  Future<Weathermodel> getWeather({required String cityName}) async {
    Uri url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=$cityName&aqi=no');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      Weathermodel weathermodel = Weathermodel(
        date: data['location']['localtime'],
        country: data['location']['country'],
        city: data['location']['name'],
        weatherstatus: data['current']['condition']['text'],
        tempC: data['current']['temp_c'].toString(),
        minTempC: 'N/A', // غير متوفر في current.json
        maxTempC: 'N/A', // غير متوفر في current.json
        icon: data['current']['condition']['icon'],
      );

      return weathermodel;
    } else {
      if (kDebugMode) {
        print('❌ Error fetching weather data');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
      throw Exception('Failed to load weather data');
    }
  }
}
