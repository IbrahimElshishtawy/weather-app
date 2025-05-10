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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https:${weatherData['icon']}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                  width: 60,
                  height: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  '${weatherData['condition']}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  'Temperature: ${weatherData['temp_c']}°C',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Humidity: ${weatherData['humidity']}%',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Wind: ${weatherData['wind_kph']} km/h',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Last Updated: ${weatherData['last_updated']}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
