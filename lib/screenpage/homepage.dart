import 'package:flutter/material.dart';
import 'package:weather/screenpage/searchpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const Searchpage(
                          weatherData: {
                            "weather": [
                              {
                                "city": "Cairo",
                                "condition": "Sunny",
                                "temp_c": 30,
                                "humidity": 50,
                                "wind_kph": 10,
                                "last_updated": "2023-10-01 12:00",
                                "icon": "https://example.com/icon.png",
                              },
                            ],
                          },

                          // Pass the weather data here if needed
                        ),
                  ),
                ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Welcome to the Weather App!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
