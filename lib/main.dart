import 'package:flutter/material.dart';
import 'package:weather/screenpage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني انتقل للصفحة الرئيسية
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // مثال لحالة الطقس، ممكن تيجي من API أو من الصفحة اللي قبلكها
    String weatherStatus = "clear"; // بدّلها بالداتا الحقيقية

    List<Color> _getWeatherColors(String weatherStatus) {
      switch (weatherStatus.toLowerCase()) {
        case 'sunny':
        case 'clear':
          return [
            const Color.fromARGB(161, 5, 90, 247),
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

    final bgColors = _getWeatherColors(weatherStatus);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
    child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // رقم أكبر = حواف أكثر دوران
        child: Image.asset(
          "assets/images/weather.jpg",
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),

    ),

    ),

    );

  }
}
