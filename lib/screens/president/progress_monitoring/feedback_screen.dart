import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  final String teamName;

  const FeedbackScreen({Key? key, required this.teamName}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  // Placeholder for feedback list (you can use a database or a state management solution for actual data)
  List<Map<String, String>> feedbackList = [
    {
      'teamName': 'Media Team',
      'feedback': 'Great progress, keep it up!',
    },
    {
      'teamName': 'Graphics team',
      'feedback': 'Good visuals, need improvement on speed.',
    },
  ];

  // Function to submit feedback
  void submitFeedback() {
    String feedbackText = _feedbackController.text.trim();

    if (feedbackText.isEmpty) {
      // If feedback is empty, show a warning
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Feedback cannot be empty!")),
      );
      return;
    }

    setState(() {
      // Adding the new feedback to the top of the list
      feedbackList.insert(0, {
        'teamName': widget.teamName,
        'feedback': feedbackText,
      });
    });

    // Clear the text field after submitting feedback
    _feedbackController.clear();
  }

  // Function to edit feedback
  void editFeedback(int index) {
    _feedbackController.text = feedbackList[index]['feedback']!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Feedback"),
          content: TextField(
            controller: _feedbackController,
            decoration: InputDecoration(labelText: "Enter Feedback"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  feedbackList[index]['feedback'] = _feedbackController.text;
                });
                Navigator.pop(context);
                _feedbackController.clear();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback for ${widget.teamName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field for feedback input
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Enter Feedback',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Submit Feedback button
            ElevatedButton(
              onPressed: submitFeedback,
              child: Text('Submit Feedback'),
            ),
            SizedBox(height: 20),
            // Display previous feedbacks
            Text(
              'Feedback History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackList.length,
                itemBuilder: (context, index) {
                  if (feedbackList[index]['teamName'] == widget.teamName) {
                    return ListTile(
                      title: Text(feedbackList[index]['teamName']!),
                      subtitle: Text(feedbackList[index]['feedback']!),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => editFeedback(index),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
