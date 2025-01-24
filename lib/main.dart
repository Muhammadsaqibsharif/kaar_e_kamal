import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/shared_prefs.dart';
import 'routes/app_routes.dart'; // Import the AppRoutes
import 'routes/route_names.dart'; // Import RouteNames

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init(); // Initialize SharedPreferences
  final isDarkMode = SharedPrefs.getThemeMode(); // Load theme mode

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({required this.isDarkMode, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  /// Function to toggle between light and dark themes
  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value; // Update the state
      SharedPrefs.setThemeMode(
          isDarkMode); // Save the state to SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Switcher App',
      theme: AppTheme.lightTheme, // Define the light theme
      darkTheme: AppTheme.darkTheme, // Define the dark theme
      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Dynamically switch themes
      initialRoute:
          RouteNames.home, // Use the RouteNames constant for initial route
      routes: AppRoutes.getRoutes(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme, // Pass the correct toggleTheme function
      ),
    );
  }
}