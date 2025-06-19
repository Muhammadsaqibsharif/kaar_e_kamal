import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/api/services/stripe_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // 1) Show an immediate feedback
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Button Pressed')),
            );
            // 2) Call your payment service, with error handling
            try {
              final result = await StripeService.instance.makePayment("200");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment succeeded')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed: $e')),
              );
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Text('Make Payment with Stripe'),
          ),
        ),
      ),
    );
  }
}
