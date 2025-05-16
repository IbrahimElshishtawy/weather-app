import 'package:flutter/material.dart';
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

  final List<String> _egyptCities = [
    'Cairo', 'Alexandria', 'Giza', 'Shubra El Kheima', 'Port Said', 'Suez',
    'Luxor', 'Mansoura', 'Tanta', 'Asyut', 'Ismailia', 'Faiyum', 'Zagazig',
    'Damietta', 'Damanhur', 'Qena', 'Aswan', 'Minya', 'Beni Suef',
  ];

  Future<void> _searchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      WeatherService service = WeatherService();
      Weathermodel newWeather = await service.getWeather(cityName: cityName);
      Navigator.pop(context, newWeather); // نرجع النتيجة للصفحة الرئيسية
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل في تحميل بيانات الطقس. حاول مرة أخرى.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for City'),
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) return const Iterable<String>.empty();
                return _egyptCities.where((city) =>
                    city.toLowerCase().startsWith(value.text.toLowerCase()));
              },
              onSelected: (String selection) {
                _controller.text = selection;
                _searchWeather(selection);
              },
              fieldViewBuilder: (context, controller, focusNode, _) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _searchWeather(value.trim());
                    }
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    style: const TextStyle(color: Colors.red),
                  )),
          ],
        ),
      ),
    );
  }
}
