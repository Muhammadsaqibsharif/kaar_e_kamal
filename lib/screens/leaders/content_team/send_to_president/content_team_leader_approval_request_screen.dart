import 'package:flutter/material.dart';

class ContentToPresidentRequestScreen extends StatefulWidget {
  const ContentToPresidentRequestScreen({Key? key}) : super(key: key);

  @override
  State<ContentToPresidentRequestScreen> createState() =>
      _ContentToPresidentRequestScreenState();
}

class _ContentToPresidentRequestScreenState
    extends State<ContentToPresidentRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedContent;
  String? _note;

  final List<String> _contentOptions = [
    'Awareness Campaign',
    'Volunteer Appreciation Post',
    'Upcoming Event Invite',
  ];

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Simulate sending content to the President
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Content sent to the President successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Content to President'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedContent,
                decoration: const InputDecoration(
                  labelText: 'Select Content',
                  border: OutlineInputBorder(),
                ),
                items: _contentOptions.map((content) {
                  return DropdownMenuItem<String>(
                    value: content,
                    child: Text(content),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedContent = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select content to send' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onSaved: (value) => _note = value,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitRequest,
                icon: const Icon(Icons.send),
                label: const Text('Send to President'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
