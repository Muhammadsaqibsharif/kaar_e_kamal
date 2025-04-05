import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OverviewStatistics extends StatelessWidget {
  const OverviewStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current theme data
    final theme = Theme.of(context);

    // Determine text color based on the theme brightness
    final textColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Circular Progress for Donations
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  animation: true,
                  percent: 0.5, // TODO: Replace with actual logic
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PKR 250K',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: textColor, // Set text color based on theme
                        ),
                      ),
                      Text(
                        'Donated',
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor, // Set text color based on theme
                        ),
                      ),
                    ],
                  ),
                  footer: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Target: PKR 500K',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                  backgroundColor: theme
                      .cardColor, // Use theme background color for progress background
                ),

                // Card for Today’s Registrations
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add_alt_1,
                            size: 30, color: theme.primaryColor),
                        const SizedBox(height: 8),
                        Text(
                          "Today's Registrations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color:
                                  textColor), // Set text color based on theme
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '25', // Static data for today’s registrations
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor, // Set text color based on theme
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
