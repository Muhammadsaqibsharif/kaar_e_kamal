import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class GraphicsTeamVolunteerDashboardScreen extends StatelessWidget {
  const GraphicsTeamVolunteerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics Team Volunteer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: [
                  _buildFeatureTile(
                    context,
                    title: 'My Tasks',
                    icon: Icons.task_alt,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.GraphicsTeamVolunteerTaskScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Send to Leader',
                    icon: Icons.send,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.GraphicsVolunteerToLeaderRequestScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Chat with Leader',
                    icon: Icons.chat,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.GraphicsVolunteerCommunicationScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Leaderboard',
                    icon: Icons.leaderboard,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.GraphicsVolunteerLeaderboardScreen);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required void Function()? onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.0, color: theme.primaryColor),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
