import 'package:flutter/material.dart';

class AuthTextFields extends StatelessWidget {
  AuthTextFields(
      {required this.hintsText,
        required this.obscureTexts,
        this.onChange,
        this.validate,
        required this.keyboardTypes});

  final String hintsText;
  final bool obscureTexts;
  Function()? validate;
  final Function(String value)? onChange;
  final TextInputType keyboardTypes;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      keyboardType: keyboardTypes,
      validator: validate!(),
      obscureText: obscureTexts,
      style: const TextStyle(
        color: Color(0xFF1D2445),
      ),
      decoration: InputDecoration(
        hintText: hintsText,
        hintStyle: const TextStyle(color: Colors.black54),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1D2445)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1D2445)),
        ),
      ),
    );
  }
}