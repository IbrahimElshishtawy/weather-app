import 'package:flutter/material.dart';
import 'package:weather/service/weather_service.dart';
class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  static String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        title: const Text('Search Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: TextField(
           
          onSubmitted: (data)
          {
            cityName = data;
            WeatherService service = WeatherService(); 
            service.getWeather(cityName: cityName!, apiKey: )

          },
          decoration: InputDecoration(
            label: Text('search'),
            contentPadding: EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 20,
            ),
            filled: false, 

            fillColor: Colors.white,
            hintText: 'Enter city name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    ), 
      );
  }
}

