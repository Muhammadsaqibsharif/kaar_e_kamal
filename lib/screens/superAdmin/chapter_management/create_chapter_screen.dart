// screens/superAdmin/chapter_management/create_chapter_screen.dart
import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/superAdmin/chapter_management/chapter_form.dart';

class CreateChapterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Chapter')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ChapterForm(),
      ),
    );
  }
}