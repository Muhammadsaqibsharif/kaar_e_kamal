import 'package:flutter/material.dart';
import 'graphics_team_leader_task_detail_screen.dart';
import 'graphics_team_leader_urgent_task_highlight_widget.dart';

class GraphicsTeamLeaderTaskDashboardScreen extends StatelessWidget {
  const GraphicsTeamLeaderTaskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        'title': 'Poster for Earth Hour Campaign',
        'description': 'Design a poster to promote Earth Hour.',
        'dueDate': 'April 9, 2025',
        'isUrgent': true,
        'status': 'Pending',
      },
      {
        'title': 'Volunteer Appreciation Graphic',
        'description': 'Create a social media post template to appreciate volunteers.',
        'dueDate': 'April 13, 2025',
        'isUrgent': false,
        'status': 'In Progress',
      },
      {
        'title': 'Blood Donation Banner',
        'description': 'Design a horizontal banner for the donation event.',
        'dueDate': 'April 10, 2025',
        'isUrgent': true,
        'status': 'Done',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics Team Tasks'),
        backgroundColor: Theme.of(context).primaryColor,
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
                  builder: (_) => GraphicsTeamLeaderTaskDetailScreen(task: task),
                ),
              );
            },
            child: GraphicsTeamLeaderUrgentTaskHighlightWidget(
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
