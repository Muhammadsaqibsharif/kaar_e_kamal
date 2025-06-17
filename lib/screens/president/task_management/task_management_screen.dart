import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<Map<String, dynamic>> tasks = [];

  final List<String> teams = [
    'Media Team',
    'Induction team',
    'Graphics team',
    'Blood Donation Team',
    'Operational Team',
    'Finance Team',
    'Content team',
    'Verification team',
    'Response Groups Team',
    'Sponsorship Team',
    'Event Team',
    'Survey Team',
    'Database Team',
    'PR Team',
    'Documentation Team',
  ];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {});
  }

  void _updateTaskStatus() {
    for (var task in tasks) {
      if (task['deadline'].isBefore(DateTime.now()) &&
          task['status'] != 'Completed') {
        task['status'] = 'Expired';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(task['taskName']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['description']),
                  Text('Team: ${task['teamName']}'),
                ],
              ),
              trailing: Chip(
                label: Text(
                  task['status'],
                  style: TextStyle(
                    color: task['status'] == 'Completed'
                        ? Colors.green
                        : task['status'] == 'In Progress'
                            ? Colors.orange
                            : task['status'] == 'Expired'
                                ? Colors.red
                                : Colors.blue,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.TaskDetailsScreen,
                  arguments: task,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context) {
    final taskNameController = TextEditingController();
    final taskDetailController = TextEditingController();
    String? selectedTeam;
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Create New Task'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(labelText: 'Task Name'),
                    ),
                    TextField(
                      controller: taskDetailController,
                      decoration: InputDecoration(labelText: 'Task Details'),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select Team'),
                      items: teams.map((team) {
                        return DropdownMenuItem(
                          value: team,
                          child: Text(team),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setStateDialog(() => selectedTeam = value),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                          "Deadline: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setStateDialog(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (taskNameController.text.isNotEmpty &&
                        taskDetailController.text.isNotEmpty &&
                        selectedTeam != null) {
                      final currentUser = FirebaseAuth.instance.currentUser;

                      if (currentUser == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not logged in.')),
                        );
                        return;
                      }

                      final userDoc = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .get();

                      final userCity = userDoc.data()?['city'] ?? 'Unknown';

                      final newTask = {
                        'taskName': taskNameController.text,
                        'description': taskDetailController.text,
                        'teamName': selectedTeam!,
                        'status': 'Pending',
                        'deadline': selectedDate,
                        'outputType': 'text',
                        'output': '',
                        'createdBy': currentUser.uid,
                        'city': userCity,
                        'createdAt': FieldValue.serverTimestamp(),
                      };

                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .add(newTask);

                      setState(() {
                        tasks.add(newTask);
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
