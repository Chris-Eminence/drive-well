import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/auth_helper.dart';

Future<Map<String, dynamic>?> createBooking(BuildContext context, int duration) async {
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
      if (responseData['success'] == true) {
        String authorizationUrl = responseData['booking']['payment']['authorization_url'];
        print("This is the payment link: $authorizationUrl");

        if (await canLaunchUrl(Uri.parse(authorizationUrl))){
          await launch(authorizationUrl);
        } else {
          throw 'Could not launch $authorizationUrl';
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking failed: ${responseData['message']}')),
        );
      }

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
