class WeatherModel {
  final String cityName;
  final DateTime date;
  final String? image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.date,
    required this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCondition,
  });

  factory WeatherModel.formJson(Map<String, dynamic> json) {
    final forecastDay = json['forecast']['forecastday'][0]['day']; // 👈 fixed

    return WeatherModel(
      cityName: json['location']['name'],
      date: DateTime.parse(json['current']['last_updated']),
      image: forecastDay['condition']['icon'],
      temp: (forecastDay['avgtemp_c'] as num).toDouble(),
      maxTemp: (forecastDay['maxtemp_c'] as num).toDouble(),
      minTemp: (forecastDay['mintemp_c'] as num).toDouble(),
      weatherCondition: forecastDay['condition']['text'],
    );
  }
}
