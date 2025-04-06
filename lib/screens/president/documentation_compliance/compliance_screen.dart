import 'package:flutter/material.dart';

class ComplianceScreen extends StatefulWidget {
  const ComplianceScreen({Key? key}) : super(key: key);

  @override
  _ComplianceScreenState createState() => _ComplianceScreenState();
}

class _ComplianceScreenState extends State<ComplianceScreen> {
  // A list to hold policies
  List<Map<String, String>> policyList = [];

  // Controller for adding/editing policy title and description
  TextEditingController policyTitleController = TextEditingController();
  TextEditingController policyDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizational Policies'),
        backgroundColor:
            Theme.of(context).primaryColor, // Dark Green from theme
        foregroundColor: Colors.white, // Text on AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Compliance Checklist',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show form to create new policy
                _showPolicyForm(context, null);
              },
              child: const Text('Add New Policy'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: policyList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 3,
                    child: ListTile(
                      title: Text(policyList[index]['title']!),
                      subtitle: Text(policyList[index]['description']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Edit the selected policy
                              _showPolicyForm(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Delete the selected policy
                              _deletePolicy(index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // Open the policy details for viewing/editing
                        _showPolicyDetails(context, index);
                      },
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

  // Method to show the policy form for creating/editing a policy
  void _showPolicyForm(BuildContext context, int? index) {
    if (index != null) {
      // If index is not null, we're editing an existing policy, so pre-fill the fields
      policyTitleController.text = policyList[index]['title']!;
      policyDescriptionController.text = policyList[index]['description']!;
    } else {
      // Reset fields for adding a new policy
      policyTitleController.clear();
      policyDescriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index != null ? 'Edit Policy' : 'Add New Policy'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: policyTitleController,
                decoration: const InputDecoration(
                  labelText: 'Policy Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: policyDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Policy Description',
                ),
                maxLines: 4,
              ),
            ],
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
                if (policyTitleController.text.isNotEmpty &&
                    policyDescriptionController.text.isNotEmpty) {
                  if (index != null) {
                    // Update existing policy
                    _updatePolicy(index);
                  } else {
                    // Add new policy
                    _addPolicy();
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Method to add a new policy to the list
  void _addPolicy() {
    setState(() {
      policyList.add({
        'title': policyTitleController.text,
        'description': policyDescriptionController.text,
      });
    });
  }

  // Method to update an existing policy
  void _updatePolicy(int index) {
    setState(() {
      policyList[index] = {
        'title': policyTitleController.text,
        'description': policyDescriptionController.text,
      };
    });
  }

  // Method to delete a policy
  void _deletePolicy(int index) {
    setState(() {
      policyList.removeAt(index);
    });
  }

  // Method to show policy details (view/edit) on tap
  void _showPolicyDetails(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(policyList[index]['title']!),
          content: Text(policyList[index]['description']!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
