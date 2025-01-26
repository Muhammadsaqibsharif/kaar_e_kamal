import 'package:flutter/material.dart';

class DonationUsageReportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Wrap the entire Column in Center widget to horizontally align
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding for better spacing
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Ensures that the Column takes up minimum space
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle report generation logic
              },
              child: Text('Generate Donation Usage Report'),
            ),
            SizedBox(height: 16),
            Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Donation Summary',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Donations: \Rs. 1,500,000\nProjects Supported: 3\nTransparency Status: Verified',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign:
                          TextAlign.center, // Aligns text within the Card
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
