import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Check if the user is already logged in
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve the user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc['Role'] ?? '';
        String routeName = _getRouteForRole(role);

        // Navigate to the appropriate screen based on the role
        if (routeName.isNotEmpty) {
          Navigator.pushReplacementNamed(context, routeName);
        } else {
          // If the role is not found, stay on the login screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Role not found.")),
          );
        }
      } else {
        // User document not found, log out and stay on the login screen
        await FirebaseAuth.instance.signOut();
      }
    }
  }

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

    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in with Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: idOrEmail,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;

        // Store UID in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', uid);
        print("User id is " + uid);

        // Retrieve role from Firestore
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          String role = userDoc['Role'] ?? '';

          // Based on the role, route to the appropriate screen
          String routeName = _getRouteForRole(role);

          // Navigate to the correct screen based on the role
          if (routeName.isNotEmpty) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login successful!")),
            );
            Navigator.pushReplacementNamed(context, routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Role not found.")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User document not found.")),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      String errorMessage = "An error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getRouteForRole(String role) {
    switch (role) {
      case 'General User':
        return RouteNames.UserHomeScreen2;
      case 'Super Admin':
        return RouteNames.dashboard;
      case 'President':
        return RouteNames.PresidentDashboardScreen;
      case 'Content Team Leader':
        return RouteNames.ContentTeamLeaderDashboardScreen;
      case 'Documentation Team Volunteer':
        return RouteNames.ContentTeamVolunteerDashboardScreen;
      case 'Graphics Team Leader':
        return RouteNames.GraphicsTeamLeaderDashboardScreen;
      case 'Graphics Team Volunteer':
        return RouteNames.GraphicsTeamVolunteerDashboardScreen;
      default:
        return ''; // Role not found
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
                      onPressed: () {
                        // Google Sign-in logic (can be added later)
                      },
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
