import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static const String _themeModeKey = 'theme_mode';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getThemeMode() {
    return _prefs.getBool(_themeModeKey) ?? false; // Default is light mode
  }

  static Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeModeKey, isDarkMode);
  }
}
