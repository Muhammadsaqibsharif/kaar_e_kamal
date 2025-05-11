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
      isDarkMode = newValue;
    });
    widget.onThemeChange(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF31511E), Color(0xFF859F3D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: const Icon(
              Icons.brightness_6_rounded,
              color: Color(0xFF31511E),
              size: 34,
            ),
            title: const Text(
              'Theme Mode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              isDarkMode ? 'Dark Mode Enabled' : 'Light Mode Enabled',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            trailing: CustomSwitch(
              value: isDarkMode,
              onChanged: _toggleTheme,
            ),
            onTap: () {
              _toggleTheme(!isDarkMode);
            },
          ),
        ),
      ),
    );
  }
}
