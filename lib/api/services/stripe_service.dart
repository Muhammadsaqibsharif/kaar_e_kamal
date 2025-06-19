import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kaar_e_kamal/api/payment/const.dart';

class StripeService {
  StripeService._();

  static final StripeService _instance = StripeService._();

  static StripeService get instance => _instance;

  Future<void> makePayment(String amount) async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(amount, "USD");
      if (paymentIntentClientSecret == null) {
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Kaar e Kamal',
        ),
      );
      await _processPayment();

      // await Stripe.instance.presentPaymentSheet();
      print('Payment successful');
    } catch (e) {
      print('Error making payment: $e');
      throw Exception('Payment failed');
    }
  }

  Future<String?> _createPaymentIntent(String amount, String currency) async {
    try {
      final Dio dio = Dio();

      Map<String, dynamic> data = {
        'amount': _CalculateAmount(int.parse(amount)),
        'currency': currency,
      };
      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          }));

      if (response.data != null) {
        // print(response.data);
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print('Error creating payment intent: $e');
      // throw Exception('Failed to create payment intent');
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print("Error processing payment: $e");
    }
  }

  String _CalculateAmount(int amount) {
    // Convert the amount to the smallest currency unit (e.g., cents for USD)
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString(); // Return as a string
  }
}
