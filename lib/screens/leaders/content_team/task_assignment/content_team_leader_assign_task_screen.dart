import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Task Management',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const ContentTeamLeaderAssignTaskScreen(),
//     );
//   }
// }

class ContentTeamLeaderAssignTaskScreen extends StatefulWidget {
  const ContentTeamLeaderAssignTaskScreen({super.key});

  @override
  State<ContentTeamLeaderAssignTaskScreen> createState() =>
      _ContentTeamLeaderAssignTaskScreenState();
}

class _ContentTeamLeaderAssignTaskScreenState
    extends State<ContentTeamLeaderAssignTaskScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      'description': 'Design caption for Ramadan Campaign',
      'member': 'Ayesha Khan',
      'date': DateTime.now().add(const Duration(days: 3)),
      'status': 'Pending',
      'output':
          'Here is the sample caption: "Reflect. Rejoice. Ramadan Mubarak!"'
    },
    {
      'description': 'Write copy for Blood Drive Poster',
      'member': 'Ahmed Raza',
      'date': DateTime.now().add(const Duration(days: 5)),
      'status': 'In Progress',
      'output': 'Donate blood, save lives. Join our drive this Friday at 5 PM!'
    },
    {
      'description': 'Finalize Eid Greetings',
      'member': 'Sara Malik',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'Completed',
      'output': 'May this Eid bring joy, peace, and blessings. Eid Mubarak!'
    },
  ];

  final List<String> teamMembers = [
    'Ayesha Khan',
    'Ahmed Raza',
    'Sara Malik',
    'Hamza Farooq'
  ];

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
                      'output': 'No output yet.',
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

  void _showTaskDetails(Map<String, dynamic> task) {
    bool isCompleted = task['status'] == 'Completed';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Task Details",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
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
              const SizedBox(height: 16),
              Text('📤 Output:',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(task['output'] ?? 'No output submitted yet.'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: task['output']))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Output copied!')),
                          );
                        });
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Output'),
                    ),
                  ],
                ),
              ),
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
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task sent for Revision')),
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

  Widget _buildTaskTile(Map<String, dynamic> task) {
    final isUrgent =
        (task['date'] as DateTime).difference(DateTime.now()).inDays <= 2;
    final isCompleted = task['status'] == 'Completed';

    final gradient = isCompleted
        ? LinearGradient(colors: [Colors.grey[400]!, Colors.grey[300]!])
        : isUrgent
            ? const LinearGradient(colors: [Colors.red, Colors.orange])
            : LinearGradient(colors: [
                Theme.of(context).primaryColor.withOpacity(0.8),
                Theme.of(context).primaryColor.withOpacity(0.5)
              ]);

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(task['description'],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(
          '${task['member']} • ${DateFormat.yMMMd().format(
            task['date'] is String
                ? DateTime.tryParse(task['date']) ?? DateTime.now()
                : task['date'],
          )}',
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        trailing: Chip(
          label:
              Text(task['status'], style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black.withOpacity(0.3),
        ),
        onTap: () => _showTaskDetails(task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Tasks'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) => _buildTaskTile(tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
