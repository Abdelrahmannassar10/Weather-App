import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app_nassar/model/weather_model.dart';

class WeatherService {
  final Dio dio;

  // Use HTTPS instead of HTTP
  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "1a8d3bce7ac948de924160549252706";

  WeatherService({required this.dio});

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final String url =
          "$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no";

      log("Requesting weather data from: $url");

      Response response = await dio.get(url);

      log("Response status: ${response.statusCode}");
      log("Response data: ${response.data}");

      WeatherModel weatherModel = WeatherModel.formJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      log("Dio error: ${e.toString()}");
      log("Response data: ${e.response?.data}");
      log("Status code: ${e.response?.statusCode}");

      final String errorMessage = e.response?.data['error']?['message'] ??
          "Oops, there was an error. Please try again later.";
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
