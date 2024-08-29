import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  HourlyForecast({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  final String time;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              temperature,
            ),
          ],
        ),
      ),
    );
  }
}
