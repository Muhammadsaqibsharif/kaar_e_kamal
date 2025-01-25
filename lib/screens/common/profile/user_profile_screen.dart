import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/profile/info_row.dart';
import 'package:kaar_e_kamal/widgets/common/profile/profile_avatar.dart';

class UserProfileScreen extends StatelessWidget {
  final String imgPath;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userType;

  const UserProfileScreen({
    super.key,
    required this.imgPath,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ProfileAvatar(assetPath: imgPath),
            ),
            const SizedBox(height: 20),
            InfoRow(label: 'User ID', value: userId),
            InfoRow(label: 'Name', value: userName),
            InfoRow(label: 'Email', value: userEmail),
            InfoRow(label: 'Phone', value: userPhone),
            InfoRow(label: 'User Type', value: userType),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: userName);
    final TextEditingController emailController =
        TextEditingController(text: userEmail);
    final TextEditingController phoneController =
        TextEditingController(text: userPhone);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform save operation here (e.g., send data to a database or API)
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
