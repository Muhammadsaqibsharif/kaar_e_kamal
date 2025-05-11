import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'donation_card.dart';
import 'package:intl/intl.dart';

class DonationList extends StatelessWidget {
  const DonationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text("Please login to view your donations."));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('donation_records')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No donation records found."));
        }

        final donations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
            final amount = donation['amount'] ?? '0';
            final paymentMethod = donation['payment_method'] ?? 'Unknown';
            final timestamp = donation['date'] as Timestamp;
            final date = DateFormat('dd MMM yyyy').format(timestamp.toDate());

            return DonationCard(
              title: 'Payment: $paymentMethod\nDate: $date',
              amount: 'R.S $amount',
              
            );
          },
        );
      },
    );
  }
}
