import 'package:flutter/material.dart';

class BadgesWidget extends StatelessWidget {
  final List<String> badges = [
    'First-Time Donor Badge',
    'Frequent Donor Badge',
    'Top Donor Badge',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: badges.map((badge) {
        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              badge,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: Icon(
              Icons.star,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
