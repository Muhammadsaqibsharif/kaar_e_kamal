import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EmergencyProtocolsScreen extends StatefulWidget {
  const EmergencyProtocolsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyProtocolsScreen> createState() =>
      _EmergencyProtocolsScreenState();
}

class _EmergencyProtocolsScreenState extends State<EmergencyProtocolsScreen> {
  List<Map<String, dynamic>> protocols = [];
  final picker = ImagePicker();

  void _addProtocolDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();
    DateTime? selectedDate;
    XFile? image;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Emergency Protocol'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: const Text('Pick Protocol Image'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Protocol Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: 'Protocol Detail'),
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
                      ? 'Pick Protocol Date'
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
                    protocols.insert(0, {
                      'name': nameController.text,
                      'detail': detailController.text,
                      'image': File(image!.path),
                      'date': selectedDate,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(int index) {
    TextEditingController nameController =
        TextEditingController(text: protocols[index]['name']);
    TextEditingController detailController =
        TextEditingController(text: protocols[index]['detail']);
    DateTime selectedDate = protocols[index]['date'] ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Protocol'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Protocol Name'),
            ),
            TextField(
              controller: detailController,
              decoration: const InputDecoration(labelText: 'Protocol Detail'),
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
                protocols[index]['name'] = nameController.text;
                protocols[index]['detail'] = detailController.text;
                protocols[index]['date'] = selectedDate;
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _deleteProtocol(int index) {
    setState(() {
      protocols.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Emergency Protocols'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: protocols.isEmpty
                  ? const Center(child: Text('No protocols yet. Tap + to add.'))
                  : ListView.builder(
                      itemCount: protocols.length,
                      itemBuilder: (context, index) {
                        final protocol = protocols[index];
                        final date = protocol['date'];

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: protocol['image'] != null
                                      ? Image.file(
                                          protocol['image'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.event,
                                              size: 40, color: Colors.white),
                                        ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        protocol['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        protocol['detail'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              size: 16,
                                              color: Colors.blueAccent),
                                          const SizedBox(width: 4),
                                          Text(
                                            date != null
                                                ? DateFormat('EEEE, MMM d, y')
                                                    .format(date)
                                                : 'Date not set',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .color),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.orange),
                                      onPressed: () => _showUpdateDialog(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => _deleteProtocol(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: _addProtocolDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Add New Protocol'),
            ),
          ],
        ),
      ),
    );
  }
}
