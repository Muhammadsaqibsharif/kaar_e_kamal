import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue, // Default active color
    this.inactiveThumbColor = Colors.grey,
    this.inactiveTrackColor = Colors.black26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (bool newValue) {
        onChanged(newValue); // Trigger callback with new value
      },
      activeColor: activeColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
    );
  }
}
