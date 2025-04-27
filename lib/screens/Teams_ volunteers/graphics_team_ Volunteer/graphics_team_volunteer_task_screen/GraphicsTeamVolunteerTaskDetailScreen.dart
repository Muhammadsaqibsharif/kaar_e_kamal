import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GraphicsTeamVolunteerTaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const GraphicsTeamVolunteerTaskDetailScreen({super.key, required this.task});

  @override
  State<GraphicsTeamVolunteerTaskDetailScreen> createState() =>
      _GraphicsTeamVolunteerTaskDetailScreenState();
}

class _GraphicsTeamVolunteerTaskDetailScreenState
    extends State<GraphicsTeamVolunteerTaskDetailScreen> {
  String? selectedFileName;
  String? selectedImagePath;

  // Pick Image
  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        selectedImagePath = result.files.single.path;
        selectedFileName = result.files.single.name;
      });
    }
  }

  // Submit the selected image
  void _submitImage() {
    final image = selectedImagePath;

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image.")),
      );
      return;
    }

    // TODO: Handle image submission logic here (e.g., upload to backend)

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Image submitted to team leader!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Info
              Text(
                task['title'],
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 6),
                  Text("Due: ${task['dueDate']}"),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                task['description'],
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),

              // Image Submission
              Text(
                "Select and submit your image:",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Choose Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
              ),
              if (selectedImagePath != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(selectedImagePath!),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitImage,
                  child: const Text("Submit Image to Leader"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
