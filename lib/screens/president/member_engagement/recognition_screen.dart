import 'package:flutter/material.dart';

class RecognitionScreen extends StatelessWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recognition & Appreciation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Recognizing the contributions of our dedicated members!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display the list of recognized members
            const Text(
              'Recognized Volunteers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with real data
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('M${index + 1}'),
                      ),
                      title: Text('Member ${index + 1}'),
                      subtitle:
                          Text('Recognized for contributing to XYZ initiative'),
                      trailing: const Icon(Icons.star, color: Colors.yellow),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Button to add new recognition
            ElevatedButton(
              onPressed: () {
                // Implement recognition logic here
                _addRecognitionDialog(context);
              },
              child: const Text('Add Recognition'),
            ),
          ],
        ),
      ),
    );
  }

  // Add recognition dialog
  void _addRecognitionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recognize a Volunteer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Volunteer Name'),
            ),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Reason for Recognition'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Logic to add recognition
            },
            child: const Text('Recognize'),
          ),
        ],
      ),
    );
  }
}
