import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String> onSaved;
  final TextEditingController controller; // Added controller

  CustomInputField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.onSaved,
    this.validator,
    required this.controller, // Controller passed here
  });

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller, // Use the controller
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: isDarkTheme
              ? Colors.white
              : Colors.black, // Adjust label color based on theme
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          color: isDarkTheme
              ? Colors.white70
              : Colors.black54, // Adjust hint color based on theme
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkTheme
                ? Colors.white
                : theme
                    .primaryColor, // Adjust focused border color based on theme
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkTheme
                ? Colors.white
                : theme.primaryColor, // Adjust border color based on theme
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkTheme
                ? Colors.white
                : theme
                    .primaryColor, // Adjust enabled border color based on theme
          ),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      style: TextStyle(
        color: isDarkTheme
            ? Colors.white
            : Colors.black, // Adjust text color based on theme
      ),
    );
  }
}
