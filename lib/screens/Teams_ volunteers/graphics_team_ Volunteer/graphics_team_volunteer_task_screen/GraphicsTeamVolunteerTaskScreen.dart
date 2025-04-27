import 'package:flutter/material.dart';
import 'GraphicsTeamVolunteerTaskDetailScreen.dart';
import 'GraphicsTeamVolunteerUrgentTaskHighlightWidget.dart';

class GraphicsTeamVolunteerTaskScreen extends StatelessWidget {
  const GraphicsTeamVolunteerTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample tasks
    final tasks = [
      {
        'title': 'Design Event Poster',
        'description': 'Create a poster for the upcoming fundraiser event.',
        'dueDate': 'April 11, 2025',
        'isUrgent': true,
        'status': 'Assigned',
      },
      {
        'title': 'Create Social Media Graphics',
        'description': 'Design graphics for social media posts.',
        'dueDate': 'April 13, 2025',
        'isUrgent': false,
        'status': 'Assigned',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tasks'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      GraphicsTeamVolunteerTaskDetailScreen(task: task),
                ),
              );
            },
            child: GraphicsTeamVolunteerUrgentTaskHighlightWidget(
              title: task['title'] as String,
              dueDate: task['dueDate'] as String,
              isUrgent: task['isUrgent'] as bool,
              status: task['status'] as String,
            ),
          );
        },
      ),
    );
  }
}
