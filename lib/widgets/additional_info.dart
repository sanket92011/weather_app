import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
    required this.image,
    required this.infoText,
    required this.value,
  });

  final IconData image;
  final String infoText;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          image,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(infoText),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
