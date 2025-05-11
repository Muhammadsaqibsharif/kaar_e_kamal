import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../widgets/user/donation/donation_list.dart';

class DonationManagementScreen extends StatefulWidget {
  const DonationManagementScreen({Key? key}) : super(key: key);

  @override
  State<DonationManagementScreen> createState() =>
      _DonationManagementScreenState();
}

class _DonationManagementScreenState extends State<DonationManagementScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedPaymentMethod;

  Future<void> _makeDonation() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You need to be logged in to donate.")),
      );
      return;
    }

    final amount = _amountController.text.trim();
    if (amount.isEmpty || _selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter amount and select payment method.")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('donation_records')
          .add({
        'amount': amount,
        'payment_method': _selectedPaymentMethod,
        'date': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Donated RS.$amount Successfully.")),
      );

      // Clear fields after donation
      _amountController.clear();
      setState(() {
        _selectedPaymentMethod = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

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
                          flex: 2,
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
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField<String>(
                            value: _selectedPaymentMethod,
                            items: const [
                              DropdownMenuItem(
                                value: 'Credit Card',
                                child: Text('Credit Card'),
                              ),
                              DropdownMenuItem(
                                value: 'Bank Transfer',
                                child: Text('Bank Transfer'),
                              ),
                              DropdownMenuItem(
                                value: 'Easypaisa',
                                child: Text('Easypaisa'),
                              ),
                              DropdownMenuItem(
                                value: 'JazzCash',
                                child: Text('JazzCash'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Payment Method',
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(Icons.payment,
                                  color: theme.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: ElevatedButton(
                        onPressed: _makeDonation,
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
