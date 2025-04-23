import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GraphicsTeamLeaderAssignTaskScreen extends StatefulWidget {
  const GraphicsTeamLeaderAssignTaskScreen({super.key});

  @override
  State<GraphicsTeamLeaderAssignTaskScreen> createState() =>
      _GraphicsTeamLeaderAssignTaskScreenState();
}

class _GraphicsTeamLeaderAssignTaskScreenState
    extends State<GraphicsTeamLeaderAssignTaskScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      'description': 'Design Poster for Ramadan Campaign',
      'member': 'Ali Khan',
      'date': DateTime.now().add(const Duration(days: 2)),
      'status': 'Pending',
      'outputImage': 'assets/Images/1.jpg',
      'revisionNote': '',
    },
    {
      'description': 'Create Banner for Blood Drive',
      'member': 'Hina Ijaz',
      'date': DateTime.now().add(const Duration(days: 5)),
      'status': 'In Progress',
      'outputImage': 'assets/Images/2.jpg',
      'revisionNote': '',
    },
    {
      'description': 'Finalize Eid Greeting Graphic',
      'member': 'Usman Tariq',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'Completed',
      'outputImage': 'assets/Images/3.jpg',
      'revisionNote': '',
    },
  ];

  final List<String> teamMembers = ['Ali Khan', 'Hina Ijaz', 'Usman Tariq'];

  void _showAddTaskDialog() {
    final TextEditingController descController = TextEditingController();
    String? selectedMember;
    DateTime? selectedDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Assign New Task",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Assign To',
                  border: OutlineInputBorder(),
                ),
                items: teamMembers.map((member) {
                  return DropdownMenuItem(
                    value: member,
                    child: Text(member),
                  );
                }).toList(),
                onChanged: (value) => selectedMember = value,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.date_range),
                label: Text(selectedDate == null
                    ? 'Select Due Date'
                    : DateFormat.yMMMd().format(selectedDate!)),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (descController.text.isEmpty ||
                      selectedMember == null ||
                      selectedDate == null) return;

                  setState(() {
                    tasks.insert(0, {
                      'description': descController.text.trim(),
                      'member': selectedMember!,
                      'date': selectedDate!,
                      'status': 'Pending',
                      'outputImage': 'assets/Images/1.jpg',
                      'revisionNote': '',
                    });
                  });

                  Navigator.pop(context);
                },
                child: const Text('Assign Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveAssetImageToGallery(String assetPath) async {
    try {
      if (Platform.isAndroid) {
        final photosStatus = await Permission.photos.request();
        final storageStatus = await Permission.storage.request();

        if (!photosStatus.isGranted && !storageStatus.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('❗ Permission denied to access storage.')),
          );
          return;
        }
      }

      final byteData = await rootBundle.load(assetPath);
      final Uint8List bytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File(
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
      ).create();
      await file.writeAsBytes(bytes);

      await FlutterImageGallerySaver.saveFile(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Image saved to gallery!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error saving image: $e')),
      );
    }
  }

  void _showTaskDetails(Map<String, dynamic> task) {
    final bool isCompleted = task['status'] == 'Completed';
    final TextEditingController revisionController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Task Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📝 Description: ${task['description']}'),
              const SizedBox(height: 8),
              Text('👤 Assigned to: ${task['member']}'),
              const SizedBox(height: 8),
              Text('📅 Due Date: ${DateFormat.yMMMd().format(task['date'])}'),
              const SizedBox(height: 8),
              Text('📌 Status: ${task['status']}'),
              const SizedBox(height: 12),
              Text('🎨 Output Image:',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(task['outputImage']),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _saveAssetImageToGallery(task['outputImage']),
                icon: const Icon(Icons.download),
                label: const Text('Download Image'),
              ),
              const SizedBox(height: 16),
              if (!isCompleted) ...[
                const Text("✏️ Add Revision Note:"),
                const SizedBox(height: 8),
                TextField(
                  controller: revisionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Use lighter background',
                    border: OutlineInputBorder(),
                  ),
                ),
              ]
            ],
          ),
        ),
        actions: [
          if (!isCompleted)
            TextButton(
              onPressed: () {
                setState(() {
                  task['status'] = 'Accepted';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task marked as Accepted')),
                );
              },
              child: const Text('Accept ✅'),
            ),
          if (!isCompleted)
            TextButton(
              onPressed: () {
                setState(() {
                  task['status'] = 'Needs Revision';
                  task['revisionNote'] = revisionController.text.trim();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Revision requested')),
                );
              },
              child: const Text('Request Revision ✏️'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics Team Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(task['description']),
              subtitle: Text(
                  'Assigned to: ${task['member']} • Due: ${DateFormat.yMMMd().format(task['date'])}'),
              trailing: Text(
                task['status'],
                style: TextStyle(
                    color: task['status'] == 'Completed'
                        ? Colors.green
                        : (task['status'] == 'Needs Revision'
                            ? Colors.red
                            : Colors.orange)),
              ),
              onTap: () => _showTaskDetails(task),
            ),
          );
        },
      ),
    );
  }
}
