import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:kaar_e_kamal/api/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ADDED

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idOrEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    final String idOrEmail = _idOrEmailController.text.trim();
    final String password = _passwordController.text.trim();

    if (idOrEmail.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all fields.")),
      );
      return;
    }

    final loginData = {
      'idOrEmail': idOrEmail,
      'password': password,
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiController.post('/auth/login', loginData);

      final data = jsonDecode(response.body);
      print("Response type debug: ${data.runtimeType}");
      print("Data keys: ${data.keys}");
      print("Full data: $data");

      if (response.statusCode == 200) {
        final id = data['userId'];
        final token = data['accessToken'];

        if (id != null && id.length >= 2) {
          // ✅ Save accessToken & userId in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', token);
          await prefs.setString('userId', id);

          String prefix = id.substring(0, 2);

          switch (prefix) {
            case 'GE':
              Navigator.pushReplacementNamed(
                  context, RouteNames.UserHomeScreen2);
              break;
            case 'PR':
              Navigator.pushReplacementNamed(
                  context, RouteNames.PresidentDashboardScreen);
              break;
            case 'CL':
              Navigator.pushReplacementNamed(
                  context, RouteNames.ContentTeamLeaderDashboardScreen);
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Unknown ID prefix: $prefix")),
              );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid or missing ID")),
          );
        }
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Login failed";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        print(Text(" Error2: $error"));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      print(Text("Error2: ${e.toString()}"));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/KK Urdu Golden.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to Kaar-e-Kamal!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _idOrEmailController,
                    decoration: const InputDecoration(
                      labelText: "User ID or Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.blue),
                      label: const Text("Sign in with Google"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.SignUpScreen);
                    },
                    child: const Text(
                      "Don't have an account? Sign up here",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ✅ Check login status function (call this in main or splash screen)
Future<void> checkLoginStatus(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String? userId = prefs.getString('userId');

  if (token != null && token.isNotEmpty && userId != null) {
    String prefix = userId.substring(0, 2);
    switch (prefix) {
      case 'GE':
        Navigator.pushReplacementNamed(context, RouteNames.UserHomeScreen2);
        break;
      case 'PR':
        Navigator.pushReplacementNamed(
            context, RouteNames.PresidentDashboardScreen);
        break;
      case 'CL':
        Navigator.pushReplacementNamed(
            context, RouteNames.ContentTeamLeaderDashboardScreen);
        break;
      default:
        // optional: logout or send to login if prefix is weird
        break;
    }
  } else {
    Navigator.pushReplacementNamed(context, RouteNames.LoginScreen);
  }
}
