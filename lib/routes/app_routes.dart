import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/core/theme/theme_settings_screen.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/test.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  /// Method to get application routes
  static Map<String, WidgetBuilder> getRoutes({
    required ValueChanged<bool>
        toggleTheme, // Use ValueChanged<bool> for clarity
    required bool isDarkMode,
  }) {
    return {
      RouteNames.home: (context) => HomeScreen(
            toggleTheme: toggleTheme,
            isDarkMode: isDarkMode,
          ),
      RouteNames.themeSettings: (context) => ThemeSettingsScreen(
            onThemeChange: toggleTheme, // Updated callback name
            initialDarkMode: isDarkMode, // Updated parameter name for clarity
          ),
      RouteNames.testing: (context) => Testing(), // Add TestingScreen route
    };
  }
}
