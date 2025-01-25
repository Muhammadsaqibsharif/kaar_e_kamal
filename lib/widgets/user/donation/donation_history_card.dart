import 'package:flutter/material.dart';

class DonationHistoryCard extends StatelessWidget {
  final double amount;
  final String date;

  DonationHistoryCard({required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          'Donation Amount: PKR ${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.color, // Use primary text color
          ),
        ),
        subtitle: Text(
          'Date: $date',
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color, // Use subtitle text color
          ),
        ),
        trailing: Icon(
          Icons.payment,
          color: Theme.of(context).primaryColor, // Use primary color for icon
        ),
      ),
    );
  }
}
