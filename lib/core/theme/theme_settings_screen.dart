import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/custom_switch.dart';

class ThemeSettingsScreen extends StatefulWidget {
  final bool initialDarkMode;
  final ValueChanged<bool> onThemeChange;

  const ThemeSettingsScreen({
    Key? key,
    required this.initialDarkMode,
    required this.onThemeChange,
  }) : super(key: key);

  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.initialDarkMode;
  }

  void _toggleTheme(bool newValue) {
    setState(() {
      isDarkMode = newValue; // Update the local state
    });
    widget.onThemeChange(newValue); // Inform the parent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Toggle Theme Mode',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomSwitch(
              value: isDarkMode, // Bind the updated state
              onChanged: _toggleTheme, // Update the state on toggle
            ),
          ],
        ),
      ),
    );
  }
}
