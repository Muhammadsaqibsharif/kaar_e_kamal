import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_volunteer_task_screen/ContentTeamVolunteerTaskDetailScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_ volunteers/content_team_ Volunteer/content_team_volunteer_task_screen/ContentTeamVolunteerUrgentTaskHighlightWidget.dart';

class ContentTeamVolunteerTaskScreen extends StatelessWidget {
  const ContentTeamVolunteerTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample tasks
    final tasks = [
      {
        'title': 'Write Caption for Fundraiser',
        'description': 'Create a short, catchy caption for the donation post.',
        'dueDate': 'April 11, 2025',
        'isUrgent': true,
        'status': 'Assigned',
      },
      {
        'title': 'Create Instagram Story Text',
        'description': 'Write engaging text for a Blood Camp Instagram story.',
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
                      ContentTeamVolunteerTaskDetailScreen(task: task),
                ),
              );
            },
            child: ContentTeamVolunteerUrgentTaskHighlightWidget(
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
