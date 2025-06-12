import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'PostDetailsPage.dart';
import 'package:firebase_auth/firebase_auth.dart'; // make sure this is imported if not already

class PresidentPostPage extends StatefulWidget {
  @override
  State<PresidentPostPage> createState() => _PresidentPostPageState();
}

class _PresidentPostPageState extends State<PresidentPostPage> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  File? _selectedImage;
  String? _base64Image;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // Image picker function
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });

      final bytes = await picked.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  // Add post to Firestore

  Future<void> _addPost() async {
    if (_titleController.text.trim().isEmpty ||
        _detailsController.text.trim().isEmpty ||
        _base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields and pick an image."),
      ));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get current user's UID
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User not logged in."),
        ));
        setState(() => _isLoading = false);
        return;
      }

      // Fetch user's city from 'users' collection
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || userDoc.data()?['city'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your city information is missing."),
        ));
        setState(() => _isLoading = false);
        return;
      }

      final city = userDoc.data()!['city'];

      // Add new post document
      final docRef =
          await FirebaseFirestore.instance.collection('updates').add({
        'title': _titleController.text.trim(),
        'details': _detailsController.text.trim(),
        'imageBase64': _base64Image,
        'createdAt': Timestamp.now(),
        'city': city, // 👈 add city here
      });

      // Update with postId
      await FirebaseFirestore.instance
          .collection('updates')
          .doc(docRef.id)
          .update({
        'postId': docRef.id,
      });

      _titleController.clear();
      _detailsController.clear();
      setState(() {
        _selectedImage = null;
        _base64Image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Update added successfully!"),
      ));
    } catch (e) {
      print("Error adding post: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to add update. Please try again."),
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Delete post from Firestore
  Future<void> _deletePost(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('updates')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Update deleted successfully."),
      ));
    } catch (e) {
      print("Error deleting post: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to delete update."),
      ));
    }
  }

  // Open post details page
  void _openDetails(DocumentSnapshot postDoc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailsPage(postDoc: postDoc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Updates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _detailsController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _addPost,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Update'),
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1),
                const SizedBox(height: 8),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('updates')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text('Something went wrong.');
                    }

                    final posts = snapshot.data?.docs ?? [];

                    if (posts.isEmpty) {
                      return Text(
                        'No updates yet.',
                        style: theme.textTheme.bodyMedium,
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final imageBase64 = post['imageBase64'] as String;
                        final imageBytes = base64Decode(imageBase64);

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                imageBytes,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                            ),
                            title: Text(post['title']),
                            subtitle: Text(
                              post['details'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deletePost(post.id),
                            ),
                            onTap: () => _openDetails(post),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const CircularProgressIndicator(),
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
