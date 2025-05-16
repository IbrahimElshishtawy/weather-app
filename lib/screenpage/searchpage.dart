import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/service/weather_service.dart';
import 'package:weather/model/weathermodel.dart';

class Searchpage extends StatefulWidget {
  final Map<String, dynamic> weatherData;

  const Searchpage({super.key, required this.weatherData});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _controller = TextEditingController();

  Weathermodel? get _currentWeather {
    try {
      if (widget.weatherData.isEmpty) return null;
      return Weathermodel.fromMap(widget.weatherData);
    } catch (_) {
      return null;
    }
  }

  Future<void> _searchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      WeatherService service = WeatherService();
      Weathermodel newWeather = await service.getWeather(cityName: cityName);
      // ignore: use_build_context_synchronously
      Navigator.pop(context, newWeather);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
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

  // ✅ روابط Lottie من الإنترنت بدل assets
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
    final hasWeather = _currentWeather != null;
    final bgColors =
        hasWeather
            ? _getWeatherColors(_currentWeather!.weatherstatus)
            : [Colors.white, Colors.white];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for City'),
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          if (hasWeather)
            Positioned.fill(
              child: Lottie.network(
                _getLottieAnimation(_currentWeather!.weatherstatus),
                fit: BoxFit.cover,
                repeat: true,
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  onSubmitted: (data) async {
                    if (data.trim().isNotEmpty) {
                      await _searchWeather(data.trim());
                    }
                  },
                  decoration: const InputDecoration(
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
                const SizedBox(height: 30),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (_errorMessage != null)
                  Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),

                const Spacer(),
                const Text(
                  'By Ibrahim El shishtawy',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
