import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';
import 'package:kaar_e_kamal/widgets/president/dashboard/president_dashboard_widget.dart';

class PresidentDashboardScreen extends StatelessWidget {
  const PresidentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('President Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.UserProfileScreen);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
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
              // Dashboard summary card and statistics can be added here
              // const DashboardSummaryCard(),
              const SizedBox(height: 16),
              const PresidentDashboardWidget(
                cityName: 'Lahore',
                totalUsers: 878,
                donationPercent: 0.5, // 50% progress
                donationsRaised: 250000,
                targetDonation: 500000,
                todayRegistrations: 17,
              ),

              // Grid Layout for Features
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  children: [
                    _buildFeatureTile(context,
                        title: 'Predictions',
                        icon: Icons.batch_prediction, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.PredictionsScreenRoute);
                    }),
                    _buildFeatureTile(context,
                        title: 'Team Management',
                        icon: Icons.group_add, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.TeamManagmentScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Reports', icon: Icons.report, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.ChapterPerformanceReportScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Task Management', icon: Icons.task, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.TaskManagementScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Progress Monitoring',
                        icon: Icons.track_changes, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.TeamProgressScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Communication', icon: Icons.message, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.PresidentCommunicationScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Events Management',
                        icon: Icons.event, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.PresidentEventManagementScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Member Engagement',
                        icon: Icons.people, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.EncourageVolunteersScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Resource Management',
                        icon: Icons.storage, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.ManageResourcesScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Super Admin Collaboration',
                        icon: Icons.supervised_user_circle, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.SuperAdminPresidentChatScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Documentation',
                        icon: Icons.document_scanner, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.MaintainDocumentationScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Compliance', icon: Icons.policy, onTap: () {
                      Navigator.pushNamed(context, RouteNames.ComplianceScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Post Now', icon: Icons.post_add, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.PresidentPostPageRoute);
                    }),
                  ],
                ),
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
    required void Function()? onTap, // Add onTap as a parameter
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap, // Use the passed onTap function
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color changed to white
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
