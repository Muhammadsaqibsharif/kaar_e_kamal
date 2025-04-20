import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ContentTeamVolunteerTaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const ContentTeamVolunteerTaskDetailScreen({super.key, required this.task});

  @override
  State<ContentTeamVolunteerTaskDetailScreen> createState() =>
      _ContentTeamVolunteerTaskDetailScreenState();
}

class _ContentTeamVolunteerTaskDetailScreenState
    extends State<ContentTeamVolunteerTaskDetailScreen> {
  final TextEditingController _contentController = TextEditingController();
  String? selectedFileName;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
      // TODO: Upload logic here
    }
  }

  void _submitContent() {
    final submittedText = _contentController.text;
    final file = selectedFileName;

    if (submittedText.isEmpty && file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please submit either text or a file.")),
      );
      return;
    }

    // TODO: Handle submission logic here (e.g., send to backend)

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Content submitted to team leader!")),
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

              // Text Submission
              Text(
                "Submit your content (text):",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write your caption or content here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // File Submission
              Text(
                "Or upload a file:",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: const Text("Choose File"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
              ),
              if (selectedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Selected: $selectedFileName"),
                ),

              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitContent,
                  child: const Text("Submit to Leader"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
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
