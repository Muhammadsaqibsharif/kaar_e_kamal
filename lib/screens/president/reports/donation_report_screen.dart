import 'package:flutter/material.dart';

class DonationReportScreen extends StatefulWidget {
  @override
  _DonationReportScreenState createState() => _DonationReportScreenState();
}

class _DonationReportScreenState extends State<DonationReportScreen> {
  // Sample static data for donation statistics
  final List<DonationData> donationData = [
    DonationData('Jan', 5000),
    DonationData('Feb', 3000),
    DonationData('Mar', 8000),
    DonationData('Apr', 7000),
  ];

  String selectedDonationPeriod = '1 Day';
  TextEditingController targetController =
      TextEditingController(text: '10000'); // Default target

  double calculateDonationProgress(String period) {
    int targetAmount = int.tryParse(targetController.text) ?? 10000;
    int totalDonation = 0;

    // Adjust donation calculation based on the selected period
    if (period == '1 Day') {
      totalDonation = donationData[0].amount;
    } else if (period == '3 Days') {
      totalDonation =
          donationData.take(2).fold(0, (sum, data) => sum + data.amount);
    } else if (period == '7 Days') {
      totalDonation =
          donationData.take(3).fold(0, (sum, data) => sum + data.amount);
    } else if (period == '1 Month') {
      totalDonation = donationData.fold(0, (sum, data) => sum + data.amount);
    } else if (period == '1 Year') {
      totalDonation = donationData.fold(0, (sum, data) => sum + data.amount);
    }

    // Prevent division by zero
    if (targetAmount == 0) return 0.0;
    return totalDonation / targetAmount;
  }

  int getTotalDonation(String period) {
    int totalDonation = 0;

    if (period == '1 Day') {
      totalDonation = donationData[0].amount;
    } else if (period == '3 Days') {
      totalDonation =
          donationData.take(2).fold(0, (sum, data) => sum + data.amount);
    } else if (period == '7 Days') {
      totalDonation =
          donationData.take(3).fold(0, (sum, data) => sum + data.amount);
    } else if (period == '1 Month') {
      totalDonation = donationData.fold(0, (sum, data) => sum + data.amount);
    } else if (period == '1 Year') {
      totalDonation = donationData.fold(0, (sum, data) => sum + data.amount);
    }
    return totalDonation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Donation Report',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation Statistics',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<String>(
                      value: selectedDonationPeriod,
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColor),
                      items: <String>[
                        '1 Day',
                        '3 Days',
                        '7 Days',
                        '1 Month',
                        '1 Year'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDonationPeriod = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: targetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Target (PKR)',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Show Donation Amount for the Selected Period
            Center(
              child: Text(
                'Donation Amount for ${selectedDonationPeriod}: R.s ${getTotalDonation(selectedDonationPeriod)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Circular Progress Indicator for Donation Progress
            Center(
              child: SizedBox(
                height: 150, // Increase size of the progress indicator
                width: 150, // Increase size of the progress indicator
                child: CircularProgressIndicator(
                  value: calculateDonationProgress(selectedDonationPeriod),
                  strokeWidth: 8.0,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Donation Progress: ${(calculateDonationProgress(selectedDonationPeriod) * 100).toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model class
class DonationData {
  final String month;
  final int amount;

  DonationData(this.month, this.amount);
}
