import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'dart:convert';
import 'package:kaar_e_kamal/api/api_controller.dart'; // Make sure this is imported

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idOrEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

// Import the necessary package for JSON decoding

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

    try {
      final response = await ApiController.post('/auth/login', loginData);

      final data = jsonDecode(response.body);
      print("Response type debug: ${data.runtimeType}");
      print("Data keys: ${data.keys}");
      print("Full data: $data");

      // Check if the response status code is OK (200)
      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = jsonDecode(response.body);

        // Print the decoded data to inspect the structure
        print("Decoded Response Data: $data");

        // You can also use jsonEncode to pretty-print the structure
        print("Pretty-printed Response: ${jsonEncode(data)}");

        // Now, access the data field you need
        final id = data['userId']; // Assume 'role' is part of the response

        if (id != null && id.length >= 2) {
          String prefix = id.substring(0, 2); // Get the first two characters

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

        // if (role != null) {
        //   switch (role) {
        //     case 'general_member':
        //       Navigator.pushReplacementNamed(
        //           context, RouteNames.UserHomeScreen2);
        //       break;
        //     case 'president':
        //       Navigator.pushReplacementNamed(
        //           context, RouteNames.PresidentDashboardScreen);
        //       break;
        //     case 'content_leader':
        //       Navigator.pushReplacementNamed(
        //           context, RouteNames.ContentTeamLeaderDashboardScreen);
        //       break;
        //     default:
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text("Unknown role: $role")),
        //       );
        //   }
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text("Invalid credentials or unknown role.")),
        //   );
        // }
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Login failed";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        print(Text(" Error2: " + error));
      }
    } catch (e) {
      // Handle any errors like network issues or JSON decoding issues
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      print(Text("Error2: ${e.toString()}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
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

              // ID/Email field
              TextField(
                controller: _idOrEmailController,
                decoration: const InputDecoration(
                  labelText: "User ID or Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),

              // Password field
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
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login button
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

              // Google sign-in button (placeholder)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add Google sign-in logic
                  },
                  icon:
                      const FaIcon(FontAwesomeIcons.google, color: Colors.blue),
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

              // Sign up redirect
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
    );
  }
}
