import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/core/theme/app_theme.dart';
import 'package:kaar_e_kamal/widgets/user/blood_donation/blood_appeal_card.dart';

class BloodDonationHistoryScreen extends StatelessWidget {
  // Sample data for blood donation history with Pakistani names and numbers
  final List<Map<String, String>> donationHistory = [
    {
      'bloodType': 'A+',
      'urgency': 'High',
      'appealDetails': 'Urgent requirement for accident victim.',
      'contactInfo': 'Ali Khan, 0301-1234567'
    },
    {
      'bloodType': 'O-',
      'urgency': 'Medium',
      'appealDetails': 'Required for surgery patient.',
      'contactInfo': 'Sara Ahmed, 0321-7654321'
    },
    {
      'bloodType': 'B+',
      'urgency': 'Low',
      'appealDetails': 'Regular donation needed for hospital.',
      'contactInfo': 'Fahad Malik, 0345-9876543'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation History"),
        backgroundColor: AppTheme.lightTheme.appBarTheme
            .backgroundColor, // Use the light theme color for AppBar
        foregroundColor: AppTheme.lightTheme.appBarTheme
            .foregroundColor, // Use white text for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Blood Donation History",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20), // Spacing before the list of appeals
            Expanded(
              child: ListView.builder(
                itemCount: donationHistory.length,
                itemBuilder: (context, index) {
                  // Retrieve appeal details from the donation history data
                  var appeal = donationHistory[index];
                  return BloodAppealCard(
                    bloodType: appeal['bloodType']!,
                    urgency: appeal['urgency']!,
                    appealDetails: appeal['appealDetails']!,
                    contactInfo: appeal['contactInfo']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
