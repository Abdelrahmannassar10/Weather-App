import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_nassar/model/weather_model.dart';

class WeatherService {
  final Dio dio;
  //base url is a string that handle the domain and the repeated passes to the method
  final String baseUrl = "http://api.weatherapi.com/v1";
  final String apiKey = dotenv.env['API_KEY'] ?? "";
  WeatherService({required this.dio});
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio.get(
          '${baseUrl}/forecast.json?key=${apiKey}&q=${cityName}&days=1&aqi=no&alerts=no');
      WeatherModel weatherModel = WeatherModel.formJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          "Oops, there was an error. Please try again later.";
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception("Oops, there was an error. Please try again later.");
    }
  }
}
