import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF31511E), // Dark Green
    scaffoldBackgroundColor: Color(0xFFF6FCDF), // Light Cream
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF31511E), // Dark Green
      foregroundColor: Colors.white, // Text on AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF859F3D), // Olive Green
        foregroundColor: Colors.black, // Button Text Color
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF31511E), // Dark Green
    scaffoldBackgroundColor: Color(0xFF1A1A19), // Very Dark Shade
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF31511E), // Dark Green
      foregroundColor: Colors.white, // Text on AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF859F3D), // Olive Green
        foregroundColor: Colors.white, // Button Text Color
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );
}
