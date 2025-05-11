import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaar_e_kamal/core/theme/app_theme.dart';
import 'package:kaar_e_kamal/widgets/user/donation/donation_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationHistoryScreen extends StatefulWidget {
  @override
  _DonationHistoryScreenState createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  DateTimeRange? _selectedDateRange;
  List<Map<String, dynamic>> donationHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchDonationHistory();
  }

  Future<void> _fetchDonationHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('donation_records')
        .orderBy('date', descending: true)
        .get();

    final records = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'amount': double.tryParse(data['amount'].toString()) ?? 0.0,
        'date': (data['date'] as Timestamp).toDate(),
      };
    }).toList();

    setState(() {
      donationHistory = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donation History",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _selectDateRange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.primaryColor,
                  ),
                  child: Text(
                    _selectedDateRange == null
                        ? 'Select Date Range'
                        : 'Selected: ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.end)}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredDonations().length,
                itemBuilder: (context, index) {
                  final donation = _filteredDonations()[index];
                  final donationDate =
                      DateFormat('dd MMM yyyy').format(donation['date']);
                  return DonationHistoryCard(
                    amount: donation['amount'].toDouble(),
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

  /// Filter donations based on selected date range (if any)
  List<Map<String, dynamic>> _filteredDonations() {
    if (_selectedDateRange == null) return donationHistory;

    return donationHistory.where((donation) {
      final donationDate = DateUtils.dateOnly(donation['date'] as DateTime);
      final startDate = DateUtils.dateOnly(_selectedDateRange!.start);
      final endDate = DateUtils.dateOnly(_selectedDateRange!.end);

      return (donationDate.isAtSameMomentAs(startDate) ||
          donationDate.isAtSameMomentAs(endDate) ||
          (donationDate.isAfter(startDate) && donationDate.isBefore(endDate)));
    }).toList();
  }

  /// Date range picker — allow all past & future dates from 2020 to 2025
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: AppTheme.lightTheme,
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }
}
