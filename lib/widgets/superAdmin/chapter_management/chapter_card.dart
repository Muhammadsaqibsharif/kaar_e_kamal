// widgets/superAdmin/chapter_management/chapter_card.dart
import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final String chapterName;

  const ChapterCard({required this.chapterName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(chapterName),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}