import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:ui';

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

  final List<String> cities = [
    'Overall',
    'Lahore',
    'Karachi',
    'Islamabad',
    'Faisalabad',
    'Multan'
  ];

  String selectedDuration = '1 Month';
  String selectedCity = 'Overall';
  TextEditingController targetController = TextEditingController();

  bool isLoading = false;
  double totalDonations = 0.0;

  final Map<String, double> defaultGoals = {
    '1 Day': 30000,
    '1 Week': 100000,
    '15 Days': 200000,
    '1 Month': 500000,
    '3 Months': 1000000,
    '1 Year': 2000000,
  };

  @override
  void initState() {
    super.initState();
    fetchDonations();
  }

  Duration getSelectedDuration() {
    switch (selectedDuration) {
      case '1 Day':
        return Duration(days: 1);
      case '1 Week':
        return Duration(days: 7);
      case '15 Days':
        return Duration(days: 15);
      case '1 Month':
        return Duration(days: 30);
      case '3 Months':
        return Duration(days: 90);
      case '1 Year':
        return Duration(days: 365);
      default:
        return Duration(days: 30);
    }
  }

  Future<void> fetchDonations() async {
    setState(() {
      isLoading = true;
    });

    try {
      double total = 0.0;
      final usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        final userCity = userDoc.data()['city'] ?? '';

        // If a city is selected other than "Overall", skip non-matching cities
        if (selectedCity != 'Overall' && userCity != selectedCity) continue;

        final donationsSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userDoc.id)
            .collection('donation_records')
            .get();

        for (var donationDoc in donationsSnapshot.docs) {
          final donationData = donationDoc.data();

          if (donationData['amount'] != null && donationData['date'] != null) {
            final donationDate = (donationData['date'] as Timestamp).toDate();
            final now = DateTime.now();
            final difference = now.difference(donationDate);

            if (difference <= getSelectedDuration()) {
              double amount =
                  double.tryParse(donationData['amount'].toString()) ?? 0.0;
              total += amount;
            }
          }
        }
      }

      setState(() {
        totalDonations = total;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching donations: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double goal = targetController.text.isNotEmpty
        ? double.tryParse(targetController.text) ?? 1
        : (defaultGoals[selectedDuration] ?? 1);

    double progress = (totalDonations / goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Reports'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Duration Dropdown
                const Text(
                  'Select Duration',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedDuration,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: durations.map((duration) {
                    return DropdownMenuItem<String>(
                      value: duration,
                      child: Text(duration),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value!;
                    });
                    fetchDonations();
                  },
                ),
                const SizedBox(height: 16),

                // City Dropdown
                const Text(
                  'Select City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                    fetchDonations();
                  },
                ),
                const SizedBox(height: 16),

                // Target Text Field
                const Text(
                  'Set Target Amount (PKR)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter target amount',
                  ),
                  onChanged: (value) {
                    setState(() {}); // Update progress indicator
                  },
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
                          'PKR ${totalDonations.toStringAsFixed(0)}',
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
                        'Target: PKR ${goal.toStringAsFixed(0)} for $selectedDuration in $selectedCity',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[700]),
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
                    leading: const Icon(Icons.analytics, color: Colors.green),
                    title: Text(
                      'Donations in $selectedDuration ($selectedCity)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'PKR ${totalDonations.toStringAsFixed(0)} received out of PKR ${goal.toStringAsFixed(0)}',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading Blur + Circular Progress
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
