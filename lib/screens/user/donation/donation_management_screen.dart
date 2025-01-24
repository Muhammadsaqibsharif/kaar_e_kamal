import 'package:flutter/material.dart';
import '../../../widgets/user/donation/donation_list.dart';

class DonationManagementScreen extends StatelessWidget {
  const DonationManagementScreen({Key? key}) : super(key: key);

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
          // Top Section: "Make a Donation"
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
                    // Row for Amount and Payment Method
                    Row(
                      children: [
                        // Enter Amount Field
                        Expanded(
                          flex: 2,
                          child: TextField(
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
                        // Payment Method Dropdown
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField<String>(
                            items: const [
                              DropdownMenuItem(
                                value: 'credit_card',
                                child: Text('Credit Card'),
                              ),
                              DropdownMenuItem(
                                value: 'bank_transfer',
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
                              // Handle payment method selection
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
                    // Make Donation Button
                    SizedBox(
                      width: constraints.maxWidth, // Take the full width
                      child: ElevatedButton(
                        onPressed: () {
                          // Add donation logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white, // Button text color
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
          // Bottom Section: Donation List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  DonationList(), // Reusable widget for displaying donation cards
            ),
          ),
        ],
      ),
    );
  }
}
