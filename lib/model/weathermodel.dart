class Weathermodel {
  final String date;
  final String country;
  final String city;
  final String weatherstatus;
  final String tempC;
  final String icon;

  // min/max optional – default to 'N/A'
  final String minTempC;
  final String maxTempC;

  // ignore: prefer_typing_uninitialized_variables
  var minTemp;

  Weathermodel({
    required this.date,
    required this.country,
    required this.city,
    required this.weatherstatus,
    required this.tempC,
    required this.icon,
    this.minTempC = 'N/A',
    this.maxTempC = 'N/A',
  });

  factory Weathermodel.fromJson(dynamic json) {
    return Weathermodel(
      date: json['location']?['localtime'] ?? '',
      country: json['location']?['country'] ?? '',
      city: json['location']?['name'] ?? '',
      weatherstatus: json['current']?['condition']?['text'] ?? '',
      tempC: json['current']?['temp_c']?.toString() ?? '',
      icon: 'https:${json['current']?['condition']?['icon'] ?? ''}',
    );
  }

  /// في حالة كنت بتجيب من forecast.json كمان:
  factory Weathermodel.fromForecastJson(dynamic json) {
    return Weathermodel(
      date: json['location']?['localtime'] ?? '',
      country: json['location']?['country'] ?? '',
      city: json['location']?['name'] ?? '',
      weatherstatus: json['current']?['condition']?['text'] ?? '',
      tempC: json['current']?['temp_c']?.toString() ?? '',
      icon: 'https:${json['current']?['condition']?['icon'] ?? ''}',
      minTempC:
          json['forecast']?['forecastday']?[0]?['day']?['mintemp_c']
              ?.toString() ??
          'N/A',
      maxTempC:
          json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c']
              ?.toString() ??
          'N/A',
    );
  }

  get lastUpdated => null;

  @override
  String toString() {
    return 'Weather in $city, $country on $date: $weatherstatus, Temp: $tempC°C';
  }

  static Weathermodel? fromMap(Map<String, dynamic> weatherData) {
    return null;
  }
}
