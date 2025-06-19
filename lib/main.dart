import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kaar_e_kamal/api/payment/const.dart';
// Local imports
import 'core/theme/app_theme.dart';
import 'core/utils/shared_prefs.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //setup Stripe
  await _setup();

  // Initialize SharedPreferences
  await SharedPrefs.init();
  final isDarkMode = SharedPrefs.getThemeMode();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Run the app
  runApp(MyApp(isDarkMode: isDarkMode));
}

Future<void> _setup() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
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
      isDarkMode = value;
      SharedPrefs.setThemeMode(isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Switcher App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: RouteNames.home,
      routes: AppRoutes.getRoutes(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}
