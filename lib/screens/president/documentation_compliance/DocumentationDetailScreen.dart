import 'package:flutter/material.dart';

class DocumentationDetailScreen extends StatelessWidget {
  final int index;
  final List<Map<String, String>> documentationList;
  final Function updateDocumentationStatus;

  const DocumentationDetailScreen({
    Key? key,
    required this.index,
    required this.documentationList,
    required this.updateDocumentationStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentation Details'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Details of ${documentationList[index]['title']}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            const Text(
              'Here you can see the full details of the documentation, including any activity and decisions made during the chapter. You can either accept or reject it.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateDocumentationStatus(context, index, "Accepted", "");
                Navigator.pop(context);
              },
              child: const Text('Accept'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showRejectReasonDialog(context);
              },
              child: const Text('Reject'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show Reject reason dialog
  void _showRejectReasonDialog(BuildContext context) {
    TextEditingController rejectionReasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Provide a Reason for Rejection'),
          content: TextField(
            controller: rejectionReasonController,
            decoration: const InputDecoration(
              hintText: 'Enter rejection reason',
              labelText: 'Rejection Reason',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the status with the rejection reason
                updateDocumentationStatus(
                    context, index, "Rejected", rejectionReasonController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
