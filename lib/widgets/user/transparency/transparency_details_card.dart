import 'package:flutter/material.dart';

class TransparencyDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Wrap the Card in Center widget to align it horizontally
      child: Padding(
        padding: const EdgeInsets.all(
            16.0), // Add padding for spacing around the card
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensures the column takes up only necessary space
              children: [
                Text(
                  'Donation Report Details',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center, // Centers the title text
                ),
                SizedBox(height: 16),
                Text(
                  'You can view your donation usage details below, including specific cases and projects.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center, // Centers the description text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
