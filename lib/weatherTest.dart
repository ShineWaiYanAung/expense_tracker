import 'package:weather/weather.dart';
import 'package:flutter/material.dart';

const String apiKey1 = "6f9d73ead78b488cd2bae7bfb9c4c5bf";

class WeatherTest extends StatefulWidget {
  const WeatherTest({super.key});

  @override
  State<WeatherTest> createState() => _WeatherTestState();
}

class _WeatherTestState extends State<WeatherTest> {
  final WeatherFactory _wf = WeatherFactory(apiKey1);
  Weather? _weather;


  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("GreenLand").then((weatherData) {
      setState(() {
        _weather = weatherData;
      });
      // ✅ Print weather info in console
      print("✅ Weather data fetched successfully!");
      print("City: ${weatherData.areaName}");
      print("Temperature: ${weatherData.temperature?.celsius?.toStringAsFixed(1)} °C");
      print("Condition: ${weatherData.weatherMain}");
      print("Humidity: ${weatherData.humidity}%");
    }).catchError((e) {
      print("❌ Failed to fetch weather: $e");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Test")),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'City: ${_weather!.areaName}',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Temperature: ${_weather!.temperature?.celsius?.toStringAsFixed(1)} °C',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Weather: ${_weather!.weatherMain}',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Humidity: ${_weather!.humidity}%',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            width: 200,
            height: 200,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
            color: Colors.blue,
               image: DecorationImage(image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))
            ),
          )
        ],
      ),
    );
  }
}
