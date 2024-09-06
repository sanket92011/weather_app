import 'package:flutter/material.dart';

import 'pages/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
      theme: ThemeData.dark(useMaterial3: true)
          .copyWith(appBarTheme: const AppBarTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}
