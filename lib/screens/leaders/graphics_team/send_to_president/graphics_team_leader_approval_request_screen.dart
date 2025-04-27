import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GraphicsToPresidentRequestScreen extends StatefulWidget {
  const GraphicsToPresidentRequestScreen({Key? key}) : super(key: key);

  @override
  State<GraphicsToPresidentRequestScreen> createState() =>
      _GraphicsToPresidentRequestScreenState();
}

class _GraphicsToPresidentRequestScreenState
    extends State<GraphicsToPresidentRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final picker = ImagePicker();
  String? _selectedTask;

  final List<String> _taskOptions = [
    'Awareness Campaign',
    'Volunteer Appreciation Post',
    'Upcoming Event Invite',
    'Event Highlights Post',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitRequest() {
    if (_selectedTask == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a task.")),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please pick an image to send.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Graphic sent to the President successfully!')),
    );

    setState(() {
      _selectedImage = null;
      _selectedTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Graphic to President'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedTask,
                decoration: const InputDecoration(
                  labelText: 'Select Assigned Task',
                  border: OutlineInputBorder(),
                ),
                items: _taskOptions.map((task) {
                  return DropdownMenuItem<String>(
                    value: task,
                    child: Text(task),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTask = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a task' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text("Pick Image from Gallery"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImage!,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Text(
                          "No image selected yet.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitRequest,
                icon: const Icon(Icons.send),
                label: const Text('Send to President'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
