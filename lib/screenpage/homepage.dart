// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:weather/model/weathermodel.dart';
import 'package:weather/screenpage/searchpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, this.weatherData});
  final Weathermodel? weatherData;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Weathermodel? _weather;

  @override
  void initState() {
    super.initState();
    _weather = widget.weatherData;
  }

  Future<void> _navigateToSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Searchpage(weatherData: _weather),
      ),
    );

    if (result != null && result is Weathermodel) {
      setState(() {
        _weather = result;
      });
    }
  }

  List<Color> _getWeatherColors(String weatherStatus) {
    switch (weatherStatus.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return [
          const Color.fromARGB(255, 225, 139, 8),
          Colors.yellow.shade100
        ];
      case 'cloudy':
        return [Colors.grey.shade400, Colors.blueGrey.shade100];
      case 'rain':
      case 'rainy':
      case 'shower rain':
        return [Colors.blue.shade700, Colors.blueGrey.shade300];
      case 'snow':
        return [Colors.blueGrey.shade100, Colors.white];
      case 'thunderstorm':
        return [Colors.deepPurple.shade800, Colors.grey.shade600];
      default:
        return [Colors.blue.shade200, Colors.lightBlue.shade100];
    }
  }

  String getLocalWeatherIcon(String weatherStatus) {
    switch (weatherStatus.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return 'assets/images/clear.png';
      case 'cloudy':
        return 'assets/images/cloudy.png';
      case 'rain':
      case 'rainy':
      case 'shower rain':
        return 'assets/images/rainy.png';
      case 'snow':
        return 'assets/images/snow.png';
      case 'thunderstorm':
        return 'assets/images/thunderstorm.png';
      default:
        return 'assets/images/clear.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherStatus = _weather?.weatherStatus ?? '';
    final hasWeather = weatherStatus.isNotEmpty;

    final bgColors = hasWeather
        ? _getWeatherColors(weatherStatus)
        : [Colors.white, Colors.white];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: hasWeather
            ? _getWeatherColors(weatherStatus)[0]
            : Colors.orange,
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          color: hasWeather ? Colors.black.withOpacity(0.4) : Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToSearch,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.all(20),
                    elevation: 8,
                  ),
                  child: CircleAvatar(
                    backgroundColor: hasWeather
                        ? _getWeatherColors(weatherStatus)[0]
                        : Colors.orange,
                    radius: 24, // ممكن تغير الحجم
                    child: Icon(
                      Icons.search,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Search for a city',
                style: TextStyle(
                  fontSize: 20,
                  backgroundColor: hasWeather
                      ? _getWeatherColors(weatherStatus)[0]
                      : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: !hasWeather
                        ? const Text(
                      'Welcome to the Weather App',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة الطقس فوق اسم المدينة
                        Image.asset(
                          getLocalWeatherIcon(_weather!.weatherStatus),
                          width: 130,
                          height: 130,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _weather!.city,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _weather!.weatherStatus,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Colors.white.withOpacity(0.9),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temp: ${_weather!.tempC}°C',
                                      style:
                                      const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                        'Min: ${_weather!.minTempC}°C'),
                                    Text(
                                        'Max: ${_weather!.maxTempC}°C'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Details:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text('Date: ${_weather!.date}'),
                                    Text(
                                        'Status: ${_weather!.weatherStatus}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'By Ibrahim El shishtawy',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
