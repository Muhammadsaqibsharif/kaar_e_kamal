import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _idOrEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String enteredId = _idOrEmailController.text.trim();
    String enteredPass = _passwordController.text.trim();

    // Static auth logic for demo
    if (enteredId == 'saqib123' && enteredPass == '12345678') {
      // Navigate to Super Admin Dashboard
      Navigator.pushNamed(context, RouteNames.UserHomeScreen2);
    } else if (enteredId == 'president' && enteredPass == '12345678') {
      Navigator.pushNamed(context, RouteNames.PresidentDashboardScreen);
    } else if (enteredId == 'contentleader' && enteredPass == '12345678') {
      Navigator.pushNamed(context, RouteNames.ContentTeamLeaderDashboardScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idOrEmailController,
              decoration: const InputDecoration(
                labelText: "ID or Email",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password *",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Google Sign-In Logic Placeholder
              },
              icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
              label: const Text("Sign in with Google"),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text("Don't have an account? Sign up here"),
            )
          ],
        ),
      ),
    );
  }
}
