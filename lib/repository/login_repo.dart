import 'dart:convert';
import 'package:http/http.dart' as http;

import '../helper/auth_helper.dart';

Future<Map<String, dynamic>?> loginUserFunction(String email, String password) async {
  // const String baseUrl = 'https://test001.otecfx.com/api/auth/login';
  const String baseUrl = 'https://careerconnects.us/api/auth/login';
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token']; // Extract token
      final userId = responseData['user']['id']; // Extract user ID

      // Store the user ID and Token
      await AuthHelper.saveUserCredentials(token, userId);
      print('User Token and ID stored to SharePreference');

      // Log or use the token and user ID
      print('Login successful!');
      print('Token: $token');
      print('User ID: $userId');

      return {
        'token': token,
        'userId': userId,
        'user': responseData['user'], // Optional: Include full user data
      };
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error during login: $e');
    return null;
  }
}

