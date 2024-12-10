import 'dart:convert';
import 'package:drive_well/models/payment_model.dart';
import 'package:http/http.dart' as http;

Future<void> makePayment(Payment payment) async {
  final url = Uri.parse('https://test001.otecfx.com/api/payment/make_payment');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payment.toJson()),
    );

    if (response.statusCode == 200) {
      // Successfully sent the payment
      print('Payment successful: ${response.body}');
    } else {
      // Handle errors
      print('Payment failed: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    // Handle exceptions
    print('Error occurred: $e');
  }
}
