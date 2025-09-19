import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app_nassar/model/weather_model.dart';
import 'package:weather_app_nassar/service/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());

  WeatherModel? weatherModel;

  Future<void> getWeather({required String cityName}) async {
    try {
      emit(WeatherLoadedState(weatherModel: weatherModel!));
      print("Fetching weather for city: $cityName");

      weatherModel = await WeatherService(dio: Dio())
          .getCurrentWeather(cityName: cityName);

      if (weatherModel != null) {
        emit(WeatherLoadedState(weatherModel: weatherModel!));
      } else {
        emit(WeatherFailureState());
      }
    } catch (e, stacktrace) {
      print("Weather fetch error: $e");
      print(stacktrace);
      emit(WeatherFailureState());
    }
  }
}

