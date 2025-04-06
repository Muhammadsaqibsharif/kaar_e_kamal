import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/president/member_engagement/recognition_screen.dart';

class EncourageVolunteersScreen extends StatefulWidget {
  const EncourageVolunteersScreen({Key? key}) : super(key: key);

  @override
  _EncourageVolunteersScreenState createState() =>
      _EncourageVolunteersScreenState();
}

class _EncourageVolunteersScreenState extends State<EncourageVolunteersScreen> {
  // List to store volunteer opportunities
  List<Map<String, String>> volunteerOpportunities = [
    {'name': 'Volunteer Opportunity 1', 'details': 'Details for opportunity 1'},
    {'name': 'Volunteer Opportunity 2', 'details': 'Details for opportunity 2'},
  ];

  // Function to create a new opportunity
  void _createOpportunity(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Volunteer Opportunity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Opportunity Name'),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  detailsController.text.isNotEmpty) {
                // Adding the new opportunity to the list
                setState(() {
                  volunteerOpportunities.add({
                    'name': nameController.text,
                    'details': detailsController.text,
                  });
                });
                Navigator.pop(context); // Close the dialog
              }
            },
            child: const Text('Create'),
          ),
        ],
        backgroundColor: Theme.of(context)
            .dialogBackgroundColor, // Match dialog box color with the theme
      ),
    );
  }

  // Function to delete an opportunity
  void _deleteOpportunity(int index) {
    setState(() {
      volunteerOpportunities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encourage Volunteers'),
        backgroundColor:
            Theme.of(context).primaryColor, // Use primary theme color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Encourage participation message
            const Text(
              'Engage with our volunteers by encouraging them to take on leadership roles or participate in upcoming initiatives!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Create a volunteer opportunity button
            ElevatedButton(
              onPressed: () {
                _createOpportunity(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor, // Use primary theme color
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Create Volunteer Opportunity'),
            ),
            const SizedBox(height: 20),
            // Navigate to the recognition screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecognitionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor, // Use primary theme color
              ),
              child: const Text('View Volunteer Recognition'),
            ),
            const SizedBox(height: 20),
            // Display a list of upcoming events or initiatives
            const Text(
              'Upcoming Volunteer Opportunities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Display the list of volunteer opportunities
            Expanded(
              child: ListView.builder(
                itemCount: volunteerOpportunities.length,
                itemBuilder: (context, index) {
                  var opportunity = volunteerOpportunities[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(opportunity['name']!),
                      subtitle: Text(opportunity['details']!),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete), // Changed to delete icon
                        onPressed: () {
                          // Delete the opportunity when the delete button is clicked
                          _deleteOpportunity(index);
                        },
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
}
