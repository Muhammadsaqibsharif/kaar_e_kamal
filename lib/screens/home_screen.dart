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
        title: const Text(
          'Kaar e Kamal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF31511E), // Dark Green
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A19) : const Color(0xFFF6FCDF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStyledButton(
              context,
              'Sign Up',
              () => Navigator.pushNamed(context, RouteNames.SignUpScreen),
            ),
            _buildStyledButton(
              context,
              'Login',
              () => Navigator.pushNamed(context, RouteNames.LoginScreen),
            ),
            _buildStyledButton(
              context,
              'Go To User Home',
              () => Navigator.pushNamed(context, RouteNames.userHome),
            ),
            const SizedBox(height: 20),
            _buildStyledButton(
              context,
              'Home 2',
              () => Navigator.pushNamed(context, RouteNames.UserHomeScreen2),
            ),
            const SizedBox(height: 20),
            _buildStyledButton(
              context,
              'Super Admin Home',
              () => Navigator.pushNamed(context, RouteNames.dashboard),
            ),
            const SizedBox(height: 20),
            _buildStyledButton(
              context,
              'President Home',
              () => Navigator.pushNamed(
                  context, RouteNames.PresidentDashboardScreen),
            ),
            const SizedBox(height: 20),
            _buildStyledButton(
              context,
              'Content Team Leader',
              () => Navigator.pushNamed(
                  context, RouteNames.ContentTeamLeaderDashboardScreen),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color(0xFF859F3D), // Olive Green
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 5,
      ),
      child: Text(text),
    );
  }
}
