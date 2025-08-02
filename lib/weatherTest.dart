import 'dart:ui';

import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'features/presentation/pages/home/dash_board.dart';

const String apiKey1 = "6f9d73ead78b488cd2bae7bfb9c4c5bf";

class WeatherTest extends StatefulWidget {
  const WeatherTest({super.key});

  @override
  State<WeatherTest> createState() => _WeatherTestState();
}

class _WeatherTestState extends State<WeatherTest> {
  final WeatherFactory _wf = WeatherFactory(apiKey1);
  Weather? _currentWeather;
  List<Weather>? _forecast;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      // Get current weather
      _currentWeather = await _wf.currentWeatherByCityName("Bangkok");

      // Get 5-day forecast (every 3 hours)
      List<Weather> forecastData = await _wf.fiveDayForecastByCityName(
        "Bangkok",
      );

      // Filter forecast for today and tomorrow only
      DateTime now = DateTime.now();
      DateTime tomorrow = now.add(Duration(days: 1));

      List<Weather> todayAndTomorrow =
          forecastData.where((w) {
            DateTime time = w.date!;
            return (time.day == now.day || time.day == tomorrow.day) &&
                (time.month == now.month) &&
                (time.year == now.year);
          }).toList();

      setState(() {
        _forecast = todayAndTomorrow;
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentWeather == null || _forecast == null
              ? Center(child: CircularProgressIndicator())
              : buildUI(),
    );
  }

  Widget buildUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).cardColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          ], // Start and end colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    );
                    // Navigator.of(context).pop(); // Use po
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Text(
                  "Today Weather",
                  style: TextStyle(
                    fontFamily: "JetBrainsMono",
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_currentWeather!.areaName}',
                style: TextStyle(
                  fontFamily: "JetBrainsMono",
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                DateFormat('dd/MM/yyyy hh:mm a').format(_currentWeather!.date!),
                style: TextStyle(
                  fontFamily: "JetBrainsMono",
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.network(
                            "https://openweathermap.org/img/wn/${_currentWeather?.weatherIcon}@4x.png",
                            height: 300,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                '${_currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Text(
                                '${_currentWeather!.weatherMain}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Wind Speed , Humidity
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildEachSpeedWidget(
                          Icons.air,
                          "${_currentWeather?.windGust?.toStringAsFixed(0)} km/h",
                        ),
                        buildEachSpeedWidget(
                          Icons.water_drop_outlined,
                          "${_currentWeather?.humidity?.toStringAsFixed(0)} %",
                        ),
                        buildEachSpeedWidget(
                          Icons.cloud_outlined,
                          "${_currentWeather?.cloudiness} %",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            //These Two Rows I meant I want to 50%
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Theme.of(
                            context,
                          ).scaffoldBackgroundColor.withOpacity(0.4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(
                                child:
                              Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                   SizedBox(
                                       height :100,
                                       child: Icon(Icons.bubble_chart_outlined,size: 60,color: Colors.white,)),
                                    Text(
                                      "${_forecast![0].humidity ?? "-"} Pa",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Theme.of(
                            context,
                          ).scaffoldBackgroundColor.withOpacity(0.4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Next Hour",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(
                                child:
                                    _forecast != null && _forecast!.isNotEmpty
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              "https://openweathermap.org/img/wn/${_forecast![0].weatherIcon}@2x.png",
                                              height:
                                                  100, // You can adjust this to any size you prefer
                                            ),

                                            Text(
                                              "${_forecast![0].temperature?.celsius?.toStringAsFixed(1) ?? "-"}°C",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                        : Text(
                                          "No forecast data",
                                          style: TextStyle(color: Colors.white),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: (){

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>  _buildForecastComparisonSheet(),
                      );

                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withOpacity(0.4),
                      child: Text(
                        "Forecast",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
  Widget _buildForecastComparisonSheet() {
    // Extract 2-hour interval forecasts (e.g., 0, 2, 4, 6, ...)
    final todayForecasts = _forecast!
        .where((f) => f.date!.day == DateTime.now().day)
        .where((f) => f.date!.hour % 2 == 0)
        .toList();

    final tomorrowForecasts = _forecast!
        .where((f) => f.date!.day == DateTime.now().add(Duration(days: 1)).day)
        .where((f) => f.date!.hour % 2 == 0)
        .toList();

    final minLength = todayForecasts.length < tomorrowForecasts.length
        ? todayForecasts.length
        : tomorrowForecasts.length;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
        child: Container(
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Today & Tomorrow Forecast",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // <-- White color
                  ),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.white54),

                ..._forecast!.map((weather) {
                  final String timeFormatted = DateFormat.jm().format(weather.date!);
                  final String temp = "${weather.temperature?.celsius?.toStringAsFixed(1)}°C";
                  final String description = weather.weatherDescription ?? "";

                  return Card(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListTile(
                      leading: Image.network(
                        "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
                        height: 300,
                      ),
                      title: Text(
                        "$timeFormatted - $temp",
                        style: TextStyle(color: Colors.white,fontSize: 18), // <-- Title white
                      ),
                      subtitle: Text(
                        description,
                        style: TextStyle(color: Colors.white70,fontSize: 16), // <-- Subtitle white
                      ),
                      // Remove gray ripple & background on tap:
                      tileColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Column buildEachSpeedWidget(IconData iconData, String data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, color: Colors.white, size: 40),
        Text(
          data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
