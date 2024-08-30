import 'package:flutter/material.dart';

class CustomError extends StatefulWidget {
  const CustomError({super.key, required this.onclick});

  final VoidCallback onclick;

  @override
  State<CustomError> createState() => _CustomErrorState();
}

class _CustomErrorState extends State<CustomError> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
            child: Text(
          "Please connect to internet",
        )),
        const SizedBox(height: 10),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.deepOrange),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          onPressed: widget.onclick,
          child: const Text(
            "Connect",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
