import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/president/resource_management/resource_request_screen.dart';

class ManageResourcesScreen extends StatefulWidget {
  const ManageResourcesScreen({Key? key}) : super(key: key);

  @override
  _ManageResourcesScreenState createState() => _ManageResourcesScreenState();
}

class _ManageResourcesScreenState extends State<ManageResourcesScreen> {
  // Dummy data for resources
  final List<Map<String, dynamic>> resources = [
    {'name': 'Funds', 'allocated': 5000, 'used': 2000},
    {'name': 'Materials', 'allocated': 300, 'used': 100},
    {'name': 'Equipment', 'allocated': 50, 'used': 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Chapter Resources'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Oversee and manage your chapter resources.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final resource = resources[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(resource['name']),
                      subtitle: Text(
                          'Allocated: ${resource['allocated']} | Used: ${resource['used']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Logic to edit the resource allocation
                          _editResourceDialog(context, resource);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Redirect to Resource Request screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResourceRequestScreen()),
                );
              },
              child: const Text('Request Additional Resources'),
            ),
          ],
        ),
      ),
    );
  }

  void _editResourceDialog(BuildContext context, Map<String, dynamic> resource) {
    final TextEditingController allocatedController = TextEditingController(
      text: resource['allocated'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Resource Allocation'),
        content: TextField(
          controller: allocatedController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Allocate Funds/Resources'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                resource['allocated'] = int.parse(allocatedController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
