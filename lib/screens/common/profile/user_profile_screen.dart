import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/profile/profile_avatar.dart';

class UserProfileScreen extends StatefulWidget {
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
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
    emailController = TextEditingController(text: widget.userEmail);
    phoneController = TextEditingController(text: widget.userPhone);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveProfile() {
    // Example: you can update Firestore/API here

    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(child: ProfileAvatar(assetPath: widget.imgPath)),
            const SizedBox(height: 20),
            _buildReadOnlyField('User ID', widget.userId),
            _buildEditableField('Name', nameController),
            _buildEditableField('Email', emailController),
            _buildEditableField('Phone', phoneController),
            _buildReadOnlyField('User Type', widget.userType),
            if (isEditing)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
