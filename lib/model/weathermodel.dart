class Weathermodel {
  final String date;
  final String country;
  final String city;
  final String weatherStatus;
  final String tempC;
  final String icon;

  final String minTempC;
  final String maxTempC;

  Weathermodel({
    required this.date,
    required this.country,
    required this.city,
    required this.weatherStatus,
    required this.tempC,
    required this.icon,
    this.minTempC = 'N/A',
    this.maxTempC = 'N/A',
  });

  factory Weathermodel.fromJson(Map<String, dynamic> json) {
    return Weathermodel(
      date: json['location']?['localtime'] ?? '',
      country: json['location']?['country'] ?? '',
      city: json['location']?['name'] ?? '',
      weatherStatus: json['current']?['condition']?['text'] ?? '',
      tempC: json['current']?['temp_c']?.toString() ?? '',
      icon: 'https:${json['current']?['condition']?['icon'] ?? ''}',
    );
  }

  factory Weathermodel.fromForecastJson(Map<String, dynamic> json) {
    return Weathermodel(
      date: json['location']?['localtime'] ?? '',
      country: json['location']?['country'] ?? '',
      city: json['location']?['name'] ?? '',
      weatherStatus: json['current']?['condition']?['text'] ?? '',
      tempC: json['current']?['temp_c']?.toString() ?? '',
      icon: 'https:${json['current']?['condition']?['icon'] ?? ''}',
      minTempC: json['forecast']?['forecastday']?[0]?['day']?['mintemp_c']?.toString() ?? 'N/A',
      maxTempC: json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c']?.toString() ?? 'N/A',
    );
  }

  @override
  String toString() {
    return 'Weather in $city, $country on $date: $weatherStatus, Temp: $tempC°C';
  }
}
