import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class ContentVolunteerToLeaderRequestScreen extends StatefulWidget {
  const ContentVolunteerToLeaderRequestScreen({super.key});

  @override
  State<ContentVolunteerToLeaderRequestScreen> createState() =>
      _ContentVolunteerToLeaderRequestScreenState();
}

class _ContentVolunteerToLeaderRequestScreenState
    extends State<ContentVolunteerToLeaderRequestScreen> {
  final List<String> assignedTasks = [
    'Write Caption for Fundraiser',
    'Create Instagram Story Text',
    'Design Facebook Post',
    'Compose Event Reminder Text',
  ];

  String? selectedTask;
  final TextEditingController _submissionTextController =
      TextEditingController();
  File? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void submitRequest() {
    if (selectedTask == null || _submissionTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted successfully')),
    );

    setState(() {
      selectedTask = null;
      _submissionTextController.clear();
      selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Task to Leader'),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: TextStyle(color: textColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Task',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedTask,
                  dropdownColor: theme.cardColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: Text(
                    'Choose a task',
                    style: TextStyle(color: textColor),
                  ),
                  iconEnabledColor: textColor,
                  items: assignedTasks
                      .map((task) => DropdownMenuItem(
                            value: task,
                            child: Text(
                              task,
                              style: TextStyle(color: textColor),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTask = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                Text(
                  'Write your response',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _submissionTextController,
                  maxLines: 5,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Upload File (Optional)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Choose File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedFile != null
                            ? selectedFile!.path.split('/').last
                            : 'No file selected',
                        style: TextStyle(color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Submit to Leader'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
