import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/user/transparency/donation_usage_report_widget.dart';
import 'package:kaar_e_kamal/widgets/user/transparency/transparency_details_card.dart';

class TransparencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transparency & Accountability'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Donation Usage',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16),
            Text(
              'Users can inquire about how their donations are used and request detailed reports or updates on specific cases or projects.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32),
            TransparencyDetailsCard(),
            SizedBox(height: 16),
            DonationUsageReportWidget(),
          ],
        ),
      ),
    );
  }
}
