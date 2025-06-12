import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailsPage extends StatefulWidget {
  final DocumentSnapshot postDoc;

  const PostDetailsPage({required this.postDoc});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  String? _imageBase64;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.postDoc['title']);
    _detailsController = TextEditingController(text: widget.postDoc['details']);
    _imageBase64 = widget.postDoc['imageBase64'];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImage = File(picked.path);
        _imageBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _updatePost() async {
    await FirebaseFirestore.instance
        .collection('updates')
        .doc(widget.postDoc.id)
        .update({
      'title': _titleController.text.trim(),
      'details': _detailsController.text.trim(),
      'imageBase64': _imageBase64,
    });

    setState(() => isEditing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = base64Decode(_imageBase64!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: isEditing ? _pickImage : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  imageBytes,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              readOnly: !isEditing,
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
              readOnly: !isEditing,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              label: Text(isEditing ? 'Save Changes' : 'Edit'),
              onPressed: () {
                if (isEditing) {
                  _updatePost();
                } else {
                  setState(() => isEditing = true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
