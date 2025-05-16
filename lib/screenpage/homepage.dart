import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
        builder: (context) => const Searchpage(weatherData: {}),
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
        return [Colors.orange.shade300, Colors.yellow.shade100];
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

  // ✅ تعديل: استخدام روابط الإنترنت بدل المسارات المحلية
  String _getLottieAnimation(String weatherStatus) {
    switch (weatherStatus.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return 'https://lottie.host/1c3d5074-0fe6-48b9-bab4-9504507d0307/wA5Kme3WgP.json';
      case 'cloudy':
        return 'https://lottie.host/87e3e93d-7a92-4e9e-a688-72cfca3eb492/cF96QJ9Dqp.json';
      case 'rain':
      case 'rainy':
      case 'shower rain':
        return 'https://lottie.host/0e85fc2b-d1ad-41b4-bfdf-7be74e5d7a38/tqLmn4ZJMj.json';
      case 'snow':
        return 'https://lottie.host/0f17e058-0b16-48ec-a50f-0a1d5e8d3ed5/xX3LfV5v4H.json';
      case 'thunderstorm':
        return 'https://lottie.host/35c1c8b5-39fd-44e3-858b-8bb79084f6ed/oI3NEKue9d.json';
      default:
        return 'https://lottie.host/67de258f-8d50-45d2-b2ff-8ff9794f36e2/V4VJELbAAg.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasWeather = _weather != null;
    final bgColors =
        hasWeather
            ? _getWeatherColors(_weather!.weatherstatus)
            : [Colors.white, Colors.white];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // ✅ تعديل: استخدام Lottie.network بدل Lottie.asset
          if (hasWeather)
            Positioned.fill(
              child: Lottie.network(
                _getLottieAnimation(_weather!.weatherstatus),
                fit: BoxFit.cover,
                repeat: true,
                errorBuilder:
                    (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.wifi_off,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bgColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

          Container(
            // ignore: deprecated_member_use
            color: hasWeather ? Colors.black.withOpacity(0.4) : Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _navigateToSearch,
                  child: Column(
                    children: const [
                      Icon(Icons.search, size: 50, color: Colors.orange),
                      SizedBox(height: 5),
                      Text(
                        'البحث',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:
                          !hasWeather
                              ? const Text(
                                'Welcome to the Weather App!',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                    _weather!.weatherstatus,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${_weather!.icon}@2x.png',
                                    width: 120,
                                    height: 120,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                              size: 80,
                                            ),
                                  ),
                                  const SizedBox(height: 20),
                                  Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    // ignore: deprecated_member_use
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
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                'Min: ${_weather!.minTempC}°C',
                                              ),
                                              Text(
                                                'Max: ${_weather!.maxTempC}°C',
                                              ),
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
                                                'Status: ${_weather!.weatherstatus}',
                                              ),
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
        ],
      ),
    );
  }
}
