import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:kaar_e_kamal/screens/president/events_activity/president_event_details_screen.dart';

class PresidentEventManagementScreen extends StatefulWidget {
  const PresidentEventManagementScreen({Key? key}) : super(key: key);

  @override
  _PresidentEventManagementScreenState createState() =>
      _PresidentEventManagementScreenState();
}

class _PresidentEventManagementScreenState
    extends State<PresidentEventManagementScreen> {
  List<Map<String, dynamic>> events = [
    {'name': 'Event 1', 'detail': 'Details of event 1', 'id': 1},
    {'name': 'Event 2', 'detail': 'Details of event 2', 'id': 2},
  ];

  final picker = ImagePicker();

  void _addEventDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();
    DateTime? selectedDate;
    XFile? image;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Event'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: const Text('Pick Event Image'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: 'Event Detail'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(selectedDate == null
                      ? 'Pick Event Date'
                      : 'Date: ${DateFormat('yMMMd').format(selectedDate!)}'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    detailController.text.isNotEmpty &&
                    selectedDate != null &&
                    image != null) {
                  setState(() {
                    events.insert(0, {
                      'name': nameController.text,
                      'detail': detailController.text,
                      'image': File(image!.path),
                      'date': selectedDate,
                      'id': events.length + 1,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Event'),
            ),
          ],
        );
      },
    );
  }

  void _updateEvent(int index) {
    TextEditingController nameController =
        TextEditingController(text: events[index]['name']);
    TextEditingController detailController =
        TextEditingController(text: events[index]['detail']);
    DateTime selectedDate = events[index]['date'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            TextField(
              controller: detailController,
              decoration: const InputDecoration(labelText: 'Event Detail'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Text('Date: ${DateFormat('yMMMd').format(selectedDate)}'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                events[index]['name'] = nameController.text;
                events[index]['detail'] = detailController.text;
                events[index]['date'] = selectedDate;
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('President Event Management')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: ListTile(
              leading: event['image'] != null
                  ? Image.file(
                      event['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.event),
              title: Text(event['name']),
              subtitle: Text(event['detail']),
              onTap: () {
                // Navigate to the PresidentEventDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresidentEventDetailsScreen(
                      event: event, // Pass the complete event data
                    ),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _updateEvent(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteEvent(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEventDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
