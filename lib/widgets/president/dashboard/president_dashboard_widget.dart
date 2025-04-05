import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PresidentDashboardWidget extends StatelessWidget {
  final String cityName;
  final int totalUsers;
  final double donationPercent;
  final double donationsRaised;
  final double targetDonation;
  final double todayRegistrations; // Static data for today’s registrations

  const PresidentDashboardWidget({
    super.key,
    required this.cityName,
    required this.totalUsers,
    required this.donationPercent,
    required this.donationsRaised,
    required this.targetDonation,
    required this.todayRegistrations,
  });

  @override
  Widget build(BuildContext context) {
    // Get current theme data
    final theme = Theme.of(context);

    // Determine text color based on the theme brightness
    final textColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dashboard Summary Card (City Specific Stats)
        Card(
          color: theme.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "City: $cityName",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Users: $totalUsers",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Overview Statistics Card (Donation Progress & Today's Registrations)
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      percent:
                          donationPercent, // Dynamic value for donation progress
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PKR ${donationsRaised.toStringAsFixed(0)}',
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
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Target: PKR ${targetDonation.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.green,
                      backgroundColor: theme
                          .cardColor, // Use theme background color for progress background
                    ),

                    // Card for Today’s Registrations (Dynamic)
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
                              todayRegistrations.toStringAsFixed(
                                  0), // Static data for today’s registrations (could be dynamic)
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    textColor, // Set text color based on theme
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
        ),
      ],
    );
  }
}
