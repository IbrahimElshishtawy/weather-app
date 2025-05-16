// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/service/weather_service.dart';
import 'package:weather/model/weathermodel.dart';

class Searchpage extends StatefulWidget {
  final Weathermodel? weatherData;

  const Searchpage({super.key, required this.weatherData});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _controller = TextEditingController();

  Weathermodel? get _currentWeather {
    return widget.weatherData;
  }

  final List<String> _egyptCities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Shubra El Kheima',
    'Port Said',
    'Suez',
    'Luxor',
    'Mansoura',
    'Tanta',
    'Asyut',
    'Ismailia',
    'Faiyum',
    'Zagazig',
    'Damietta',
    'Damanhur',
    'Qena',
    'Aswan',
    'Minya',
    'Beni Suef',
  ];

  Future<void> _searchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      WeatherService service = WeatherService();
      Weathermodel newWeather = await service.getWeather(cityName: cityName);
      if (mounted) {
        Navigator.pop(context, newWeather);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل في تحميل بيانات الطقس. حاول مرة أخرى.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Color> _getWeatherColors(String? weatherStatus) {
    if (weatherStatus == null) {
      return [Colors.white, Colors.white];
    }

    switch (weatherStatus.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return [const Color.fromARGB(255, 247, 150, 5), Colors.yellow.shade100];
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

  String _getLottieAnimation(String? weatherStatus) {
    if (weatherStatus == null) {
      return 'https://lottie.host/67de258f-8d50-45d2-b2ff-8ff9794f36e2/V4VJELbAAg.json';
    }

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
    final weatherStatus = _currentWeather?.weatherstatus;
    final hasWeather = weatherStatus != null && weatherStatus.isNotEmpty;
    final bgColors = _getWeatherColors(weatherStatus);

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
                _getLottieAnimation(weatherStatus),
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
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue value) {
                    if (value.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return _egyptCities.where(
                      (city) => city.toLowerCase().startsWith(
                        value.text.toLowerCase(),
                      ),
                    );
                  },
                  onSelected: (String selection) async {
                    _controller.text = selection;
                    await _searchWeather(selection);
                  },
                  fieldViewBuilder: (
                    context,
                    controller,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onSubmitted: (value) async {
                        if (value.trim().isNotEmpty) {
                          await _searchWeather(value.trim());
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
                        hintText: 'Search for a city in Egypt',
                      ),
                    );
                  },
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
                  'By Ibrahim El Shishtawy',
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
