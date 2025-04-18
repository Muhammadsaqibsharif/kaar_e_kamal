import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class ContentTeamLeaderDashboardScreen extends StatelessWidget {
  const ContentTeamLeaderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Team Leader'),
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

              // You can place a summary widget here later
              // const ContentTeamLeaderSummaryCard(),

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
                    title: 'Task Dashboard',
                    icon: Icons.dashboard,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderTaskDashboardScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Assign Tasks',
                    icon: Icons.task,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderAssignTaskScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Team Availability',
                    icon: Icons.people_outline,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderMemberAvailabilityScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Content Editor',
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderContentEditorScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Send To President',
                    icon: Icons.send,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.ContentToPresidentRequestScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Request Approval',
                    icon: Icons.group_add,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderAddRemoveMembersScreen);
                    },
                  ),
                  _buildFeatureTile(
                    context,
                    title: 'Communication',
                    icon: Icons.chat,
                    onTap: () {
                      Navigator.pushNamed(context,
                          RouteNames.ContentTeamLeaderCommunicationScreen);
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
