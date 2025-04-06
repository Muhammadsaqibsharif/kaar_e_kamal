import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class ChapterPerformanceReportScreen extends StatefulWidget {
  @override
  _ChapterPerformanceReportScreenState createState() =>
      _ChapterPerformanceReportScreenState();
}

class _ChapterPerformanceReportScreenState
    extends State<ChapterPerformanceReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chapter Performance Report',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color(0xFF31511E), // Dark Green
        foregroundColor: Colors.white, // Text on AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Donation Statistics Section
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.DonationReportScreen);
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Color(0xFFF6FCDF), // Light Cream
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                    title: Text(
                      'Donation Report',
                      style: TextStyle(
                        color: Color(0xFF31511E), // Dark Green
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Team Activity Levels Section
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.ActivityLevelReportScreen);
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Color(0xFFF6FCDF), // Light Cream
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.group,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                    title: Text(
                      'Activity Level Report',
                      style: TextStyle(
                        color: Color(0xFF31511E), // Dark Green
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Volunteer Engagement Metrics Section
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.VolunteerEngagementReportScreen);
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Color(0xFFF6FCDF), // Light Cream
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.volunteer_activism,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                    title: Text(
                      'Volunteer Engagement Report',
                      style: TextStyle(
                        color: Color(0xFF31511E), // Dark Green
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF31511E), // Dark Green
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
