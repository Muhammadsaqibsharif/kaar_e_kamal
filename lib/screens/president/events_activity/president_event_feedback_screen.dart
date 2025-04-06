import 'package:flutter/material.dart';

class PresidentEventFeedbackScreen extends StatelessWidget {
  final int eventId;

  const PresidentEventFeedbackScreen({Key? key, required this.eventId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example feedback list
    List<Map<String, String>> feedbackList = [
      {'user': 'User1', 'feedback': 'Great event!'},
      {'user': 'User2', 'feedback': 'Very informative.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Event Feedback')),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return ListTile(
            title: Text(feedback['user']!),
            subtitle: Text(feedback['feedback']!),
          );
        },
      ),
    );
  }
}
