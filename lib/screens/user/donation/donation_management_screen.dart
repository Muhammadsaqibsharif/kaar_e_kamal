import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaar_e_kamal/api/services/stripe_service.dart';
import '../../../widgets/user/donation/donation_list.dart';
import 'package:intl/intl.dart';

class DonationManagementScreen extends StatefulWidget {
  const DonationManagementScreen({Key? key}) : super(key: key);

  @override
  State<DonationManagementScreen> createState() =>
      _DonationManagementScreenState();
}

class _DonationManagementScreenState extends State<DonationManagementScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Management'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: theme.primaryColor.withOpacity(0.05),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make a Donation',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter Amount',
                              labelStyle: TextStyle(color: theme.primaryColor),
                              border: const OutlineInputBorder(),
                              prefixText: 'PKR ',
                              prefixStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          final amount = _amountController.text.trim();

                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "You need to be logged in to donate.")),
                            );
                            return;
                          }

                          if (amount.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please enter donation amount.")),
                            );
                            return;
                          }

                          final double donationAmount =
                              double.tryParse(amount) ?? 0;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Payment...')),
                          );

                          try {
                            // Stripe Payment
                            await StripeService.instance.makePayment(amount);

                            // Store donation
                            final donationData = {
                              'amount': amount,
                              'payment_method': 'Stripe',
                              'date': DateTime.now(),
                            };

                            final userRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid);

                            await userRef
                                .collection('donation_records')
                                .add(donationData);

                            // Fetch user info
                            final userSnap = await userRef.get();
                            final userData = userSnap.data();
                            if (userData == null) return;

                            final firstName = userData['firstName'] ?? '';
                            final lastName = userData['lastName'] ?? '';
                            final monthlyTarget = double.tryParse(
                                    userData['monthly_target'].toString()) ??
                                0.0;

                            // Calculate monthly donations
                            final now = DateTime.now();
                            final startOfMonth =
                                DateTime(now.year, now.month, 1);
                            final donationRecords = await userRef
                                .collection('donation_records')
                                .where('date',
                                    isGreaterThanOrEqualTo: startOfMonth)
                                .get();

                            double monthlyTotal = 0.0;
                            for (var doc in donationRecords.docs) {
                              final amt =
                                  double.tryParse(doc['amount'].toString()) ??
                                      0;
                              monthlyTotal += amt;
                            }

                            // Prepare notification
                            String notification = '';
                            if (monthlyTotal >= monthlyTarget) {
                              notification =
                                  "🎉 Great job $firstName! You've achieved your monthly donation goal of Rs.${monthlyTarget.toStringAsFixed(0)}.";
                            } else {
                              double todayTarget = monthlyTarget / 30;
                              final today =
                                  DateFormat('yyyy-MM-dd').format(now);

                              // Filter today's donations
                              double todayTotal = 0.0;
                              for (var doc in donationRecords.docs) {
                                final date =
                                    (doc['date'] as Timestamp).toDate();
                                if (DateFormat('yyyy-MM-dd').format(date) ==
                                    today) {
                                  final amt = double.tryParse(
                                          doc['amount'].toString()) ??
                                      0;
                                  todayTotal += amt;
                                }
                              }

                              if (todayTotal >= todayTarget) {
                                notification =
                                    "👏 Well done $firstName! You’ve hit your daily donation goal of Rs.${todayTarget.toStringAsFixed(0)}.";
                              } else {
                                final adjustedTarget = monthlyTarget - 50;
                                await userRef
                                    .update({'monthly_target': adjustedTarget});
                                notification =
                                    "💪 Keep going $firstName! Let’s push a bit more to reach your new monthly goal of Rs.${adjustedTarget.toStringAsFixed(0)}.";
                              }
                            }

                            try {
                              final notifRef =
                                  userRef.collection('user_notifications');
                              await notifRef.add({
                                'message': notification,
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              print("✅ Notification saved: $notification");
                            } catch (e) {
                              print("❌ Failed to store user notification: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Failed to store encouragement notification.")),
                              );
                            }

                            // Clear input & show success
                            _amountController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Donated RS.$amount Successfully."),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Payment failed: $e')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Make Donation',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              'Your Donation Records',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DonationList(),
            ),
          ),
        ],
      ),
    );
  }
}
