import 'package:weather_app_nassar/model/weather_model.dart';

class WeatherState {}
class WeatherInitialState extends WeatherState{}
class WeatherLoadedState extends WeatherState{
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}
class WeatherFailureState extends WeatherState{}