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
        throw Exception('Failed to create payment intent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Kaar e Kamal',
        ),
      );

      await _processPayment(); // Will throw if cancelled or failed
      print('Payment successful');
    } catch (e) {
      print('Error making payment: $e');
      throw Exception('Payment failed');
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet(); // Handles confirmation too
    } catch (e) {
      print("Error processing payment: $e");
      throw Exception("Payment not completed");
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
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print('Error creating payment intent: $e');
      return null;
    }
  }

  String _CalculateAmount(int amount) {
    return (amount * 100).toString(); // Convert to cents
  }
}
