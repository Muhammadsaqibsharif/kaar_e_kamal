// import 'package:flutter/material.dart';

// class AppTheme {
//   static final lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Color(0xFF31511E), // Dark Green
//     scaffoldBackgroundColor: Color(0xFFF6FCDF), // Light Cream
//     appBarTheme: AppBarTheme(
//       backgroundColor: Color(0xFF31511E), // Dark Green
//       foregroundColor: Colors.white, // Text on AppBar
//     ),
//     buttonTheme: ButtonThemeData(
//       buttonColor: Color(0xFF859F3D), // Olive Green
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Color(0xFF1A1A19)), // Dark Text
//       bodyMedium: TextStyle(color: Color(0xFF1A1A19)), // Dark Text
//     ),
//   );

//   static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Color(0xFF31511E), // Dark Green
//     scaffoldBackgroundColor: Color(0xFF1A1A19), // Very Dark Shade
//     appBarTheme: AppBarTheme(
//       backgroundColor: Color(0xFF31511E), // Dark Green
//       foregroundColor: Colors.white, // Text on AppBar
//     ),
//     buttonTheme: ButtonThemeData(
//       buttonColor: Color(0xFF859F3D), // Olive Green
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.white), // Light text on dark mode
//       bodyMedium: TextStyle(color: Colors.white), // Light text on dark mode
//     ),
//   );
// }
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
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF859F3D), // Olive Green
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // White Text
      bodyMedium: TextStyle(color: Colors.white), // White Text
      bodySmall: TextStyle(color: Colors.white), // White Text (if needed)
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
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF859F3D), // Olive Green
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // White Text on Dark Mode
      bodyMedium: TextStyle(color: Colors.white), // White Text on Dark Mode
      bodySmall: TextStyle(color: Colors.white), // White Text (if needed)
    ),
  );
}
