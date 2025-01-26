import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import '../../widgets/user/home/user_home_tile.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserHomeTile(
                title: 'Donation Management',
                subtitle: 'Make donations securely or track your donations.',
                icon: Icons.volunteer_activism,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.DonationManagementScreen);
                  // Navigate to Donation Management
                },
              ),
              UserHomeTile(
                title: 'Donation History',
                subtitle: 'View your past donation records.',
                icon: Icons.history,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.DonationHistoryScreen);
                  // Navigate to Donation History
                },
              ),
              UserHomeTile(
                title: 'Transparency & Accountability',
                subtitle: 'Track donation usage with detailed reports.',
                icon: Icons.fact_check,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.TransparencyScreen);
                  // Navigate to Transparency Page
                },
              ),
              UserHomeTile(
                title: 'Gamification Elements',
                subtitle: 'Earn badges and check leaderboards.',
                icon: Icons.emoji_events,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.GamificationScreen);
                  // Navigate to Gamification Page
                },
              ),
              UserHomeTile(
                title: 'Social Engagement',
                subtitle: 'Share posts and join campaigns.',
                icon: Icons.share,
                onTap: () {
                  // Navigate to Social Engagement
                },
              ),
              UserHomeTile(
                title: 'Chatbot Interaction',
                subtitle: 'Get instant assistance with our chatbot.',
                icon: Icons.chat_bubble,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.ChatbotInteractionScreen);
                  // Navigate to Chatbot
                },
              ),
              UserHomeTile(
                title: 'Needy Family Submission',
                subtitle: 'Submit cases of needy families.',
                icon: Icons.family_restroom,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.FamilySubmissionForm);
                  // Navigate to Needy Family Submission
                },
              ),
              UserHomeTile(
                title: 'Blood Donation',
                subtitle: 'Register for blood donation or create appeals.',
                icon: Icons.bloodtype,
                onTap: () {
                  Navigator.pushNamed(
                      // context, RouteNames.BloodDonationRegistrationScreen);
                      context,
                      RouteNames.BloodRequestScreen);
                  // Navigate to Blood Donation
                },
              ),
              UserHomeTile(
                title: 'Profile Management',
                subtitle: 'Update your profile and notification preferences.',
                icon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.UserProfileScreen);
                  // Navigate to Profile Management
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
