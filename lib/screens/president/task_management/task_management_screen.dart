import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<Map<String, dynamic>> tasks = [
    {
      'taskName': 'Task 1',
      'description': 'Complete the project documentation.',
      'leaderName': 'Ali Raza',
      'teamName': 'Documentation Team',
      'status': 'Completed',
      'deadline': DateTime.now().add(Duration(days: 2)),
      'outputType': 'text',
      'output': 'Documentation completed and uploaded to Drive.',
    },
    {
      'taskName': 'Task 2',
      'description': 'Design the application interface.',
      'leaderName': 'Ayesha Khan',
      'teamName': 'Graphics team',
      'status': 'Completed',
      'deadline': DateTime.now().add(Duration(days: 1)),
      'outputType': 'image',
      'output': 'assets/Images/3.jpg',
    },
  ];

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

  final List<String> leaders = [
    'Ali Raza',
    'Ayesha Khan',
    'Ahmed Saeed',
    'Fatima Noor',
    'Bilal Tariq',
    'Hina Shah',
    'Usman Javed',
    'Sana Zafar',
  ];

  @override
  void initState() {
    super.initState();
    _updateTaskStatus(); // Update task statuses on initialization
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
                  Text(
                      'Leader: ${task['leaderName']} - Team: ${task['teamName']}'),
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
    String? selectedLeader;
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                          setState(() => selectedTeam = value),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select Leader'),
                      items: leaders.map((leader) {
                        return DropdownMenuItem(
                          value: leader,
                          child: Text(leader),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedLeader = value),
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
                          setState(() {
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
                  onPressed: () {
                    if (taskNameController.text.isNotEmpty &&
                        taskDetailController.text.isNotEmpty &&
                        selectedTeam != null &&
                        selectedLeader != null) {
                      setState(() {
                        tasks.add({
                          'taskName': taskNameController.text,
                          'description': taskDetailController.text,
                          'leaderName': selectedLeader,
                          'teamName': selectedTeam,
                          'status': 'Pending',
                          'deadline': selectedDate,
                          'outputType': null,
                          'output': null,
                        });
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
