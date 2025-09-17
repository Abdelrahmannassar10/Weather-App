import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app_nassar/model/weather_model.dart';
import 'package:weather_app_nassar/service/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;
  getWeather({required String cityName}) async {
    try {
      print("printing city name $cityName");
      weatherModel = await WeatherService(dio: Dio()).getCurrentWeather(cityName: cityName);

      emit(WeatherLoadedState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
