import 'package:flutter/material.dart';

class LeaderboardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData = [
    {'rank': 1, 'name': 'Ali Khan', 'donations': 100000},
    {'rank': 2, 'name': 'Fatima Bibi', 'donations': 80000},
    {'rank': 3, 'name': 'Ahmed Raza', 'donations': 60000},
    {'rank': 4, 'name': 'Zara Shah', 'donations': 50000},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: leaderboardData.length,
      itemBuilder: (context, index) {
        final user = leaderboardData[index];
        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              '${user['rank']}. ${user['name']}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Donations: \Rs.${user['donations']}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: Icon(
              Icons.star,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }
}
