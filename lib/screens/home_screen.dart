import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kaar e Kamal'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.userHome);
              },
              child: const Text('Go To user home'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.UserHomeScreen2);
              },
              child: const Text('Home 2'),
            ),
          ),
        ],
      ),
    );
  }
}
