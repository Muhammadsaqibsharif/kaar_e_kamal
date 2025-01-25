import 'package:flutter/material.dart';

class NotificationPreferencesScreen extends StatelessWidget {
  const NotificationPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Preferences"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text("Receive Notifications"),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text("Receive Email Updates"),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text("Receive SMS Alerts"),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
