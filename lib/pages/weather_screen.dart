import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/secrets.dart';
import 'package:weather/widgets/additional_info.dart';
import 'package:weather/widgets/custom_app_bar.dart';
import 'package:weather/widgets/hourly_forecast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  double pressure = 0;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Mahuva";
      final res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey",
      ));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "Error occurred";
      } else {
        return data;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: const Text("    Weather App"),
        useCustomIcon: false,
        isCenter: true,
        onClick: () {
          setState(() {});
        },
        icon: Icons.refresh,
        imagePath: '',
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];

          dynamic currentTemp = currentWeatherData['main']['temp'];
          currentTemp = currentTemp - 273.15;
          final currentSky = currentWeatherData['weather'][0]['main'];
          final description = currentWeatherData['weather'][0]['description'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final pressure = currentWeatherData['main']['pressure'];
          final humidity = currentWeatherData['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "${currentTemp.toStringAsFixed(1)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                  currentSky == "Clouds" || currentSky == "Rain"
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64),
                              const SizedBox(height: 20),
                              Text(
                                "$currentSky",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "$description".toUpperCase(),
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hourly forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      temp = data['list'][index + 1]['main']['temp'];
                      temp = temp - 273.15;
                      final formatedTemp = temp.toStringAsFixed(1);
                      final time =
                          DateTime.parse(data['list'][index + 1]['dt_txt']);
                      final sky = data['list'][index + 1]['weather'][0]['main'];
                      return HourlyForecast(
                        icon: sky == "Clouds" || sky == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                        time: DateFormat.j().format(time),
                        temperature: formatedTemp,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      image: Icons.water_drop_rounded,
                      infoText: 'Humidity',
                      value: '$humidity',
                    ),
                    AdditionalInfo(
                      image: Icons.air,
                      infoText: 'Wind Speed',
                      value: '$currentWindSpeed',
                    ),
                    AdditionalInfo(
                      image: Icons.beach_access,
                      infoText: 'Pressure',
                      value: "$pressure",
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
