import 'package:flutter/material.dart';
import 'content_team_leader_task_detail_screen.dart';
import 'content_team_leader_urgent_task_highlight_widget.dart';

class ContentTeamLeaderTaskDashboardScreen extends StatelessWidget {
  const ContentTeamLeaderTaskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample tasks with a status field added
    final tasks = [
      {
        'title': 'Caption for Earth Hour Campaign',
        'description':
            'Create an engaging caption for the upcoming Earth Hour post.',
        'dueDate': 'April 8, 2025',
        'isUrgent': true,
        'status': 'Pending', // Added status field
      },
      {
        'title': 'Volunteer Spotlight Post',
        'description': 'Highlight a volunteer of the month for Instagram.',
        'dueDate': 'April 12, 2025',
        'isUrgent': false,
        'status': 'In Progress', // Added status field
      },
      {
        'title': 'Blood Donation Drive Poster Text',
        'description':
            'Write content for a poster about the Blood Donation Drive.',
        'dueDate': 'April 10, 2025',
        'isUrgent': true,
        'status': 'Done', // Added status field
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Dashboard'),
        backgroundColor:
            Theme.of(context).primaryColor, // Use theme's primary color
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentTeamLeaderTaskDetailScreen(task: task),
                ),
              );
            },
            child: ContentTeamLeaderUrgentTaskHighlightWidget(
              title: task['title'] as String,
              dueDate: task['dueDate'] as String,
              isUrgent: task['isUrgent'] as bool,
              status: task['status'] as String, // Pass the status here
            ),
          );
        },
      ),
    );
  }
}
