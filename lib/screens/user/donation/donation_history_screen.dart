import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:kaar_e_kamal/core/theme/app_theme.dart';
import 'package:kaar_e_kamal/widgets/user/donation/donation_history_card.dart';

class DonationHistoryScreen extends StatefulWidget {
  @override
  _DonationHistoryScreenState createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  DateTimeRange? _selectedDateRange;
  List<Map<String, dynamic>> allDonationHistory = [
    {
      'amount': 5000,
      'date': DateTime(2024, 1, 5),
    },
    {
      'amount': 2000,
      'date': DateTime(2024, 1, 15),
    },
    {
      'amount': 10000,
      'date': DateTime(2024, 1, 25),
    },
  ];

  List<Map<String, dynamic>> donationHistory =
      []; // This will be filtered history

  @override
  void initState() {
    super.initState();
    // Initially show all donations
    donationHistory = allDonationHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donation History",
          style: TextStyle(color: Colors.white), // White text in AppBar
        ),
        backgroundColor:
            AppTheme.lightTheme.primaryColor, // Dark Green for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Range Picker
            Row(
              children: [
                ElevatedButton(
                  onPressed: _selectDateRange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme
                        .lightTheme.primaryColor, // Use theme's primary color
                  ),
                  child: Text(
                    _selectedDateRange == null
                        ? 'Select Date Range'
                        : 'Selected Date Range: ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.end)}',
                    style: TextStyle(
                        color: Colors.white), // White text color for the button
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Donations List
            Expanded(
              child: ListView.builder(
                itemCount: donationHistory.length,
                itemBuilder: (context, index) {
                  final donation = donationHistory[index];
                  final donationDate =
                      DateFormat('dd MMM yyyy').format(donation['date']);
                  return DonationHistoryCard(
                    amount:
                        donation['amount'].toDouble(), // Convert to double here
                    date: donationDate,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date Range Selection Function
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: AppTheme
              .lightTheme, // You can toggle between light and dark theme
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        // Filter donations based on selected date range
        _filterDonationsByDateRange();
      });
    }
  }

  // Filter donations based on selected date range
  void _filterDonationsByDateRange() {
    if (_selectedDateRange != null) {
      final filteredHistory = allDonationHistory.where((donation) {
        final donationDate = donation['date'] as DateTime;
        // Ensure that both start and end dates are correctly handled as DateTime objects
        return donationDate.isAfter(
                _selectedDateRange!.start.subtract(Duration(days: 1))) &&
            donationDate
                .isBefore(_selectedDateRange!.end.add(Duration(days: 1)));
      }).toList();

      setState(() {
        donationHistory = filteredHistory;
      });
    }
  }
}
