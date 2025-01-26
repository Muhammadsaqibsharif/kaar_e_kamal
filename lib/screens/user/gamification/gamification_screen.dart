import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/user/gamification/badges.dart';
import 'package:kaar_e_kamal/widgets/user/gamification/leaderboard.dart';

class GamificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamification'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Badges & Rewards',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              BadgesWidget(), // Badges Widget
              SizedBox(height: 32),
              Text(
                'Leaderboard',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              LeaderboardWidget(), // Leaderboard Widget
            ],
          ),
        ),
      ),
    );
  }
}
