import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/president/events_activity/president_event_feedback_screen.dart';

class PresidentEventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event; // Accept the event data

  const PresidentEventDetailsScreen({Key? key, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event['name'] ?? 'Event Details')), // Display event name
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${event['date']}'), // Display event date
            const SizedBox(height: 8),
            Text('Details: ${event['detail']}'), // Display event details
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the PresidentEventFeedbackScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresidentEventFeedbackScreen(eventId: event['id']),
                  ),
                );
              },
              child: const Text('View Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
