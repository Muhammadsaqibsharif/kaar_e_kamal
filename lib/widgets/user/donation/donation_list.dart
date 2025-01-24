import 'package:flutter/material.dart';
import 'donation_card.dart';

class DonationList extends StatelessWidget {
  const DonationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donations = [
      {'title': 'Education Fund', 'amount': '\$500'},
      {'title': 'Health Support', 'amount': '\$300'},
      {'title': 'Food Distribution', 'amount': '\$700'},
    ];

    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return DonationCard(
          title: donation['title']!,
          amount: donation['amount']!,
        );
      },
    );
  }
}
