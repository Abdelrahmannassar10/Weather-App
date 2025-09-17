import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app_nassar/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app_nassar/view/search_view.dart';
import 'package:weather_app_nassar/widget/NoWeatherApp.dart';
import 'package:weather_app_nassar/widget/weather_info_body.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather App",
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SearchView();
                }));
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return const NoWeatherApp();
            } else if (state is WeatherLoadedState) {
              return WeatherInfoBody(weather: state.weatherModel);
            } else if (state is WeatherFailureState) {
              return const Center(
                child: Text("Oops, there was an error retrieving data."),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
