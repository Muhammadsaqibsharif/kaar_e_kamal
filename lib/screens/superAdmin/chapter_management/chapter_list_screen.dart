// screens/superAdmin/chapter_management/chapter_list_screen.dart
import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/superAdmin/chapter_management/chapter_card.dart';

class ChapterListScreen extends StatelessWidget {
  final List<String> chapters = ['Lahore', 'Karachi', 'Islamabad'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chapters List')),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ChapterCard(chapterName: chapters[index]);
        },
      ),
    );
  }
}
