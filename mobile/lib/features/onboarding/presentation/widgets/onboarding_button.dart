import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color backgroundColor;
  final Color foregroundColor;

  const OnboardingButton({
    Key? key, 
    required this.text, 
    required this.onPressed, 
    required this.isPrimary, 
    required this.backgroundColor, 
    required this.foregroundColor,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? backgroundColor : backgroundColor,
        foregroundColor: isPrimary ? foregroundColor : backgroundColor, 
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text),
      
    );
  }
}