import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/auth_helper.dart';

Future<Map<String, dynamic>?> createBooking(int duration) async {
  final prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('user_token');

  print("user token $userToken");
  const String baseUrl = 'https://careerconnects.us/api/bookings';
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken', // Add token here
      },
      body: jsonEncode({
        'duration': duration,
      }),
    );

    print("this duration is: $duration");
    print(jsonEncode({'duration': duration}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("status code ${response.statusCode}");
      final responseData = jsonDecode(response.body);

      print("this is the payment response data $responseData");

      return {
        'user': responseData['bookings']['payment'],
        // Optional: Include full user data
      };
    } else {
      print("status code ${response.statusCode}");
      print('Booking fail: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error during login: $e');
    return null;
  }
}
