import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FinancialReportsScreen extends StatefulWidget {
  @override
  _FinancialReportsScreenState createState() => _FinancialReportsScreenState();
}

class _FinancialReportsScreenState extends State<FinancialReportsScreen> {
  final List<String> durations = [
    '1 Day',
    '1 Week',
    '15 Days',
    '1 Month',
    '3 Months',
    '1 Year'
  ];

  String selectedDuration = '1 Month';

  // Simulated donation data (in PKR)
  final Map<String, double> donationAmounts = {
    '1 Day': 15000,
    '1 Week': 55000,
    '15 Days': 95000,
    '1 Month': 250000,
    '3 Months': 540000,
    '1 Year': 2100000,
  };

  // Targets based on duration (just as an example)
  final Map<String, double> donationGoals = {
    '1 Day': 30000,
    '1 Week': 100000,
    '15 Days': 200000,
    '1 Month': 500000,
    '3 Months': 1000000,
    '1 Year': 2000000,
  };

  @override
  Widget build(BuildContext context) {
    double donated = donationAmounts[selectedDuration] ?? 0;
    double goal = donationGoals[selectedDuration] ?? 1;
    double progress = (donated / goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Reports'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Duration Filter
            Text(
              'Select Duration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8.0,
              children: durations.map((duration) {
                return ChoiceChip(
                  label: Text(duration),
                  selected: selectedDuration == duration,
                  onSelected: (_) {
                    setState(() {
                      selectedDuration = duration;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Donation Progress Indicator
            Center(
              child: CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 14.0,
                animation: true,
                percent: progress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PKR ${donated.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const Text(
                      'Collected',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Target: PKR ${goal.toStringAsFixed(0)} for $selectedDuration',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
                backgroundColor: Colors.grey[300]!,
              ),
            ),
            const SizedBox(height: 32),

            // Financial Summary Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.analytics, color: Colors.green),
                title: Text(
                  'Donations in $selectedDuration',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'PKR ${donated.toStringAsFixed(0)} received out of PKR ${goal.toStringAsFixed(0)}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
