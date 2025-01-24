import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final String title;
  final String amount;

  const DonationCard({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Amount: $amount',
          style: theme.textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () {
            // Edit donation functionality
          },
        ),
      ),
    );
  }
}
