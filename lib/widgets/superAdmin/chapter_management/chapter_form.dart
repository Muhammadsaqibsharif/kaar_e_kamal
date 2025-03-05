// widgets/superAdmin/chapter_management/chapter_form.dart
import 'package:flutter/material.dart';

class ChapterForm extends StatefulWidget {
  @override
  _ChapterFormState createState() => _ChapterFormState();
}

class _ChapterFormState extends State<ChapterForm> {
  final _formKey = GlobalKey<FormState>();
  String chapterName = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Chapter Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a chapter name';
              }
              return null;
            },
            onSaved: (value) => chapterName = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Handle form submission
              }
            },
            child: Text('Create Chapter'),
          ),
        ],
      ),
    );
  }
}
