import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app_nassar/view/HomeView.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: getThemeColor(
                    BlocProvider.of<GetWeatherCubit>(context)
                        .weatherModel
                        ?.weatherCondition),
              ),
              home: const Homeview(),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition.toLowerCase()) {
    case "sunny":
    case "clear":
      return Colors.amber;
    case "partly cloudy":
      return Colors.lightBlue;
    case "cloudy":
      return Colors.blueGrey;
    case "overcast":
      return Colors.grey;
    case "mist":
    case "fog":
    case "freezing fog":
      return Colors.teal;
    case "patchy rain possible":
    case "patchy light rain":
    case "light rain":
    case "light rain shower":
      return Colors.lightBlue;
    case "moderate rain":
    case "moderate rain at times":
    case "moderate or heavy rain shower":
      return Colors.blue;
    case "heavy rain":
    case "torrential rain shower":
      return Colors.indigo;
    case "light snow":
    case "patchy light snow":
    case "light snow showers":
      return Colors.cyan;
    case "moderate snow":
    case "patchy moderate snow":
    case "moderate or heavy snow showers":
      return Colors.lightBlue;
    case "heavy snow":
    case "patchy heavy snow":
      return Colors.blueGrey;
    case "thundery outbreaks possible":
    case "patchy light rain with thunder":
    case "moderate or heavy rain with thunder":
    case "patchy light snow with thunder":
    case "moderate or heavy snow with thunder":
      return Colors.deepPurple;
    default:
      return Colors.blue; // fallback
  }
}
