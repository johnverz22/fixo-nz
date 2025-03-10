import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputField({
    super.key,
    required this.controller,
    required this.label,  
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller, 
        obscureText: obscureText, 
        keyboardType: keyboardType, 
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        validator: (value) => value!.isEmpty ? '$label is required' : null,
        ),
     );
  }
}