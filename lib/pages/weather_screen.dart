import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/widgets/additional_info.dart';
import 'package:weather/widgets/custom_app_bar.dart';
import 'package:weather/widgets/hourly_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: const Text("    Weather App"),
        useCustomIcon: false,
        isCenter: true,
        onClick: () {},
        icon: Icons.refresh,
        imagePath: '',
      ),
      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "300K",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.cloud, size: 64),
                          SizedBox(height: 20),
                          Text(
                            "Rain",
                            style: TextStyle(fontSize: 20),
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
              "Weather forecast",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecast(
                    icon: Icons.cloud,
                    temperature: "301.22",
                    time: "00:00",
                  ),
                  HourlyForecast(
                    icon: Icons.sunny,
                    temperature: "301.52",
                    time: "03:00",
                  ),
                  HourlyForecast(
                    icon: Icons.cloud,
                    temperature: "300.22",
                    time: "06:00",
                  ),
                  HourlyForecast(
                    icon: Icons.sunny,
                    temperature: "300.12",
                    time: "09:00",
                  ),
                  HourlyForecast(
                    icon: Icons.cloud,
                    temperature: "301.22",
                    time: "12:00",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Additional Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfo(
                  image: Icons.water_drop_rounded,
                  infoText: 'Humidity',
                  value: '91',
                ),
                AdditionalInfo(
                  image: Icons.air,
                  infoText: 'Wind Speed',
                  value: '7.5',
                ),
                AdditionalInfo(
                  image: Icons.beach_access,
                  infoText: 'Pressure',
                  value: '1006',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
