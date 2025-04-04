import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<Map<String, dynamic>> announcements = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  int? editingIndex;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _postAnnouncement() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      if (editingIndex == null) {
        // Create new announcement
        setState(() {
          announcements.add({
            'title': _titleController.text,
            'description': _descriptionController.text,
            'image': _selectedImage,
          });
        });
      } else {
        // Update existing announcement
        setState(() {
          announcements[editingIndex!] = {
            'title': _titleController.text,
            'description': _descriptionController.text,
            'image': _selectedImage,
          };
          editingIndex = null;
        });
      }

      _titleController.clear();
      _descriptionController.clear();
      _selectedImage = null;
    }
  }

  void _editAnnouncement(int index) {
    setState(() {
      editingIndex = index;
      _titleController.text = announcements[index]['title'];
      _descriptionController.text = announcements[index]['description'];
      _selectedImage = announcements[index]['image'];
    });
  }

  void _deleteAnnouncement(int index) {
    setState(() {
      announcements.removeAt(index);
      if (editingIndex == index) {
        _titleController.clear();
        _descriptionController.clear();
        _selectedImage = null;
        editingIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Announcements')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 100)
                    : Text('No image selected'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Select Image'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _postAnnouncement,
                      child: Text(editingIndex == null ? 'Post' : 'Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(announcement['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(announcement['description']),
                        if (announcement['image'] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child:
                                Image.file(announcement['image'], height: 100),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _editAnnouncement(index),
                              child: Text('Edit'),
                            ),
                            TextButton(
                              onPressed: () => _deleteAnnouncement(index),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
