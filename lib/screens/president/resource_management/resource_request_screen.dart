import 'package:flutter/material.dart';

class ResourceRequestScreen extends StatefulWidget {
  const ResourceRequestScreen({Key? key}) : super(key: key);

  @override
  _ResourceRequestScreenState createState() => _ResourceRequestScreenState();
}

class _ResourceRequestScreenState extends State<ResourceRequestScreen> {
  final TextEditingController resourceTypeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // List to store submitted requests
  final List<Map<String, String>> _submittedRequests = [];

  void _submitRequest() {
    if (resourceTypeController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        reasonController.text.isNotEmpty) {
      // Create a new request and add it to the list
      setState(() {
        _submittedRequests.add({
          'resourceType': resourceTypeController.text,
          'quantity': quantityController.text,
          'reason': reasonController.text,
          'status': 'Pending', // Initial status
        });
      });

      // Clear text fields after submission
      resourceTypeController.clear();
      quantityController.clear();
      reasonController.clear();

      // Show confirmation message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text(
              'Your request for additional resources has been sent to the Super Admin.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Close dialog, but stay on the same screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Additional Resources'),
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Request additional support or resources from the Super Admin.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: resourceTypeController,
                decoration: const InputDecoration(
                    labelText: 'Resource Type (e.g., Funds, Materials)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonController,
                decoration:
                    const InputDecoration(labelText: 'Reason for Request'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Submitted Requests:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Displaying the submitted requests
              ListView.builder(
                shrinkWrap:
                    true, // Prevents the overflow by making ListView scrollable within limited space
                physics:
                    NeverScrollableScrollPhysics(), // Prevents scrolling of the ListView independently
                itemCount: _submittedRequests.length,
                itemBuilder: (context, index) {
                  final request = _submittedRequests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text('${request['resourceType']}'),
                      subtitle: Text(
                          'Quantity: ${request['quantity']}\nReason: ${request['reason']}'),
                      trailing: Chip(
                        label: Text(
                          request['status']!,
                          style: TextStyle(
                            color: request['status'] == 'Pending'
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
