import 'package:flutter/material.dart';

class Searchpage extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const Searchpage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    var weatherData2 = weatherData;
    return Scaffold(
      appBar: AppBar(
        title: Text('${weatherData['city']} - Weather Details'),
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onSubmitted: (data) {
              print(data);
            },

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              label: Text('Search'),
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Search for a city',
            ),
          ),
        ),
      ),
    );
  }
}
