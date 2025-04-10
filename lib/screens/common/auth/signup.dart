import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  String generatedId = '';

  void _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _generateUniqueId() {
    // For demo purposes: ID = firstName + random digits
    final random = Random();
    String id = '${_firstName.text.toLowerCase()}${random.nextInt(1000)}';
    setState(() => generatedId = id);
  }

  void _submitForm() {
    if (_firstName.text.isNotEmpty && _lastName.text.isNotEmpty && generatedId.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signed up with ID: $generatedId")),
      );
      // Navigate or Save logic here...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(Icons.add_a_photo, size: 30)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _firstName,
              decoration: const InputDecoration(labelText: "First Name"),
              onChanged: (_) => _generateUniqueId(),
            ),
            TextField(
              controller: _lastName,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _city,
              decoration: const InputDecoration(labelText: "City"),
            ),
            const SizedBox(height: 10),
            Text("Generated ID: $generatedId",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
