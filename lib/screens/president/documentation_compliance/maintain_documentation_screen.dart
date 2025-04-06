import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/president/documentation_compliance/DocumentationDetailScreen.dart';

class MaintainDocumentationScreen extends StatefulWidget {
  const MaintainDocumentationScreen({Key? key}) : super(key: key);

  @override
  _MaintainDocumentationScreenState createState() =>
      _MaintainDocumentationScreenState();
}

class _MaintainDocumentationScreenState
    extends State<MaintainDocumentationScreen> {
  // A list to hold the documentation status
  List<Map<String, String>> documentationList = List.generate(
    10,
    (index) => {
      'title': 'Documentation #${index + 1}',
      'status': 'Pending', // Initial status is Pending
    },
  );

  // A list to hold accepted and rejected documentation
  List<Map<String, String>> acceptedList = [];
  List<Map<String, String>> rejectedList = [];
  List<Map<String, String>> historyList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintain Chapter Documentation'),
        backgroundColor:
            Theme.of(context).primaryColor, // Dark Green from theme
        foregroundColor: Colors.white, // Text on AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to the history screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(
                    historyList: historyList,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Chapter Activities and Decisions',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: documentationList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 3,
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          // Navigate to a detailed screen for documentation
                          _showDocumentationDetails(context, index);
                        },
                        child: Text(documentationList[index]['title']!),
                      ),
                      subtitle:
                          Text('Status: ${documentationList[index]['status']}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Accept') {
                            _updateDocumentationStatus(
                                context, index, 'Accepted', '');
                          } else if (value == 'Reject') {
                            _showRejectReasonDialog(context, index);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'Accept',
                            child: Text('Accept'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Reject',
                            child: Text('Reject'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the detailed view of the documentation
  void _showDocumentationDetails(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentationDetailScreen(
          index: index,
          documentationList: documentationList,
          updateDocumentationStatus: _updateDocumentationStatus,
        ),
      ),
    );
  }

  // Method to show Reject reason dialog
  void _showRejectReasonDialog(BuildContext context, int index) {
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
                _updateDocumentationStatus(
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

  // Method to update documentation status with reason (if rejected)
  void _updateDocumentationStatus(
      BuildContext context, int index, String status, String reason) {
    setState(() {
      documentationList[index]['status'] = status;

      if (status == "Rejected") {
        // Move rejected item to the rejected list
        rejectedList.add({
          'title': documentationList[index]['title']!,
          'status': 'Rejected',
          'reason': reason,
        });
      } else if (status == "Accepted") {
        // Move accepted item to the accepted list
        acceptedList.add({
          'title': documentationList[index]['title']!,
          'status': 'Accepted',
        });
      }

      // Add the notification to the history list
      historyList.add({
        'title': documentationList[index]['title']!,
        'status': status,
        'reason': reason,
      });

      // Remove the documentation item from the main list
      documentationList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Documentation #${index + 1} has been $status. ${reason.isNotEmpty ? 'Reason: $reason' : ''}'),
      ),
    );
  }
}

// History Screen to show the history of accepted and rejected documentation
class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> historyList;

  const HistoryScreen({Key? key, required this.historyList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentation History'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 3,
              child: ListTile(
                title: Text(historyList[index]['title']!),
                subtitle: Text('Status: ${historyList[index]['status']}'),
                trailing: historyList[index]['reason'] != null
                    ? Text('Reason: ${historyList[index]['reason']!}')
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
