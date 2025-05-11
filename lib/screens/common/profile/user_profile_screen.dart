import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  DocumentSnapshot<Map<String, dynamic>>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        userData = doc;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _showEditProfileDialog() async {
    TextEditingController firstNameController =
        TextEditingController(text: userData?.data()?['firstName']);
    TextEditingController lastNameController =
        TextEditingController(text: userData?.data()?['lastName']);
    TextEditingController phoneController =
        TextEditingController(text: userData?.data()?['phone']);
    String? updatedImageString = userData?.data()?['profileImageString'];

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  final picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    final bytes = await picked.readAsBytes();
                    setState(() {
                      updatedImageString = base64Encode(bytes);
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: updatedImageString != null &&
                          updatedImageString!.isNotEmpty
                      ? MemoryImage(base64Decode(updatedImageString!))
                      : null,
                  child: updatedImageString == null
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({
                  'firstName': firstNameController.text.trim(),
                  'lastName': lastNameController.text.trim(),
                  'phone': phoneController.text.trim(),
                  'profileImageString': updatedImageString ?? '',
                });
                Navigator.pop(context);
                _fetchUserData();
              },
              child: const Text("Save")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEditProfileDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("No user data found."))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              userData!.data()!['profileImageString'] != null &&
                                      userData!.data()!['profileImageString'] !=
                                          ''
                                  ? MemoryImage(base64Decode(
                                      userData!.data()!['profileImageString']))
                                  : null,
                          child: userData!.data()!['profileImageString'] ==
                                      null ||
                                  userData!.data()!['profileImageString'] == ''
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "${userData!.data()!['firstName']} ${userData!.data()!['lastName']}",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildProfileInfoRow(
                                  icon: Icons.email,
                                  label: "Email",
                                  value: userData!.data()!['email'] ?? 'N/A'),
                              _buildProfileInfoRow(
                                  icon: Icons.phone,
                                  label: "Phone",
                                  value: userData!.data()!['phone'] ?? 'N/A'),
                              _buildProfileInfoRow(
                                  icon: Icons.location_city,
                                  label: "City",
                                  value: userData!.data()!['city'] ?? 'N/A'),
                              _buildProfileInfoRow(
                                  icon: Icons.verified_user,
                                  label: "Role",
                                  value: userData!.data()!['Role'] ?? 'N/A'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
