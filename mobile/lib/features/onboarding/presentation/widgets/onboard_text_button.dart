import 'package:flutter/material.dart';

class OnboardTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OnboardTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 9, 12, 155), // Text color
        padding: EdgeInsets.zero, // Removes default padding
        shape: null, // No shape/background
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
