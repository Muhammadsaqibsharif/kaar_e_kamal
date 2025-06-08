import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationReportScreen extends StatefulWidget {
  @override
  _DonationReportScreenState createState() => _DonationReportScreenState();
}

class _DonationReportScreenState extends State<DonationReportScreen> {
  String selectedDonationPeriod = '1 Day';
  TextEditingController targetController = TextEditingController(text: '10000');
  double totalDonation = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDonationData();
  }

  void fetchDonationData() async {
    setState(() {
      isLoading = true;
    });

    double total = 0.0;
    DateTime now = DateTime.now();
    DateTime startDate;

    // Set the start date based on selected period
    switch (selectedDonationPeriod) {
      case '1 Day':
        startDate = now.subtract(Duration(days: 1));
        break;
      case '3 Days':
        startDate = now.subtract(Duration(days: 3));
        break;
      case '7 Days':
        startDate = now.subtract(Duration(days: 7));
        break;
      case '1 Month':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case '1 Year':
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
      default:
        startDate = now.subtract(Duration(days: 1));
    }

    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var userDoc in userSnapshot.docs) {
      var donationRecords = await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .collection('donation_records')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .get();

      for (var record in donationRecords.docs) {
        var amountStr = record['amount'] ?? '0';
        double amount = double.tryParse(amountStr) ?? 0.0;
        total += amount;
      }
    }

    setState(() {
      totalDonation = total;
      isLoading = false;
    });
  }

  double calculateDonationProgress() {
    double targetAmount = double.tryParse(targetController.text) ?? 10000;
    if (targetAmount == 0) return 0.0;
    return totalDonation / targetAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Donation Report',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donation Statistics',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
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
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedDonationPeriod = newValue!;
                              });
                              fetchDonationData();
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
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Total Donations for $selectedDonationPeriod:\nR.s ${totalDonation.toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(
                        value: calculateDonationProgress().clamp(0.0, 1.0),
                        strokeWidth: 10.0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Donation Progress: ${(calculateDonationProgress() * 100).toStringAsFixed(2)}%',
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
          ),
          if (isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
