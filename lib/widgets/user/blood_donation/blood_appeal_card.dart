import 'package:flutter/material.dart';

class BloodAppealCard extends StatelessWidget {
  final String bloodType;
  final String urgency;
  final String appealDetails;
  final String contactInfo;

  BloodAppealCard({
    required this.bloodType,
    required this.urgency,
    required this.appealDetails,
    required this.contactInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Blood Type: $bloodType",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Urgency: $urgency",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Details: $appealDetails",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Contact Info: $contactInfo",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor, // Text color
              ),
              onPressed: () {
                // Handle the action for blood appeal
                print("Respond to Appeal");
              },
              child: Text("Respond to Appeal"),
            ),
          ],
        ),
      ),
    );
  }
}
