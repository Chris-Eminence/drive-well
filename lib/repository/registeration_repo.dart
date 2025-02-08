import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  final String baseUrl = 'https://test001.otecfx.com/api/auth';


  Future<User?> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
    required String password, confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final body = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'password': password,
      'addrress' : address,
      'password_confirmation': confirmPassword,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User registered Successfully with status code of ${response.statusCode}");
        final data = jsonDecode(response.body);
        if (data['message'] == 'User registration successful') {
          print("Successful user ${response.body}");
          return User.fromJson(data['user']);
        }
      } else {
        print('Failed to register user: with status code ${response.statusCode} and body of  ${response.body}');
      }
    } catch (e) {
      print('Error during user registration: $e');
    }
    return null;
  }
}
