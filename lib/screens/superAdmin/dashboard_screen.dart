import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/widgets/superAdmin/dashboard/dashboard_summary_card.dart';
import 'package:kaar_e_kamal/widgets/superAdmin/dashboard/overview_statistics.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
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
              const DashboardSummaryCard(),
              const SizedBox(height: 16),
              const OverviewStatistics(),

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
                        title: 'Chapter Management',
                        icon: Icons.business, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.ChapterManagementScreen);
                    }),
                    // _buildFeatureTile(context,
                    //     title: 'Chapter Management',
                    //     icon: Icons.business, onTap: () {
                    //   Navigator.pushNamed(context, RouteNames.createChapter);
                    // }),
                    _buildFeatureTile(context,
                        title: 'Access Control',
                        icon: Icons.settings_accessibility, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.AccessControlScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Communication', icon: Icons.message, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.CommunicationScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Announce',
                        icon: Icons.notification_add, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.AnnouncementsScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Donation Status',
                        icon: Icons.star_outline_sharp, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.FinancialReportsScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Manage Events', icon: Icons.event, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.CreateEventScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Reports', icon: Icons.report, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.ReportsDashboardScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Blood', icon: Icons.emergency, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.EmergencyProtocolsScreen);
                    }),
                    _buildFeatureTile(context,
                        title: 'Profile', icon: Icons.person, onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.UserProfileScreen);
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
