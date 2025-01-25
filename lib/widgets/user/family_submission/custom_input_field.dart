import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String> onSaved;

  CustomInputField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: Colors.white, // White text for the label
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          color:
              Colors.white70, // Duller hint color (slightly transparent white)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // White border when focused
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // White border
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // White border when enabled
          ),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      style: TextStyle(
        color: Colors.white, // White text for the input field
      ),
    );
  }
}
