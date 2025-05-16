import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weathermodel.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1/';
  String apiKey = '28e634beb3c440b694b151731250305'; // تأكد من صلاحيته

  Future<Weathermodel> getWeather({required String cityName}) async {
    Uri url = Uri.parse(
      '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no',
    );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      // نحاول نجيب min/max temp لو موجودين
      String minTemp = 'N/A';
      String maxTemp = 'N/A';

      try {
        minTemp =
            data['forecast']['forecastday'][0]['day']['mintemp_c'].toString();
        maxTemp =
            data['forecast']['forecastday'][0]['day']['maxtemp_c'].toString();
      } catch (e) {
        // لو حصلت مشكلة في الوصول للبيانات، نخليهم N/A
        minTemp = 'N/A';
        maxTemp = 'N/A';
      }

      Weathermodel weathermodel = Weathermodel(
        date: data['location']['localtime'],
        country: data['location']['country'],
        city: data['location']['name'],
        weatherstatus: data['current']['condition']['text'],
        tempC: data['current']['temp_c'].toString(),
        minTempC: minTemp,
        maxTempC: maxTemp,
        icon: data['current']['condition']['icon'],
      );

      return weathermodel;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
