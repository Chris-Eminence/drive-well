import 'dart:convert';
import 'package:http/http.dart' as http;

// Login logic
Future<bool> loginUserFunction(String email, String password) async {
  // const String baseUrl = 'https://test001.otecfx.com/api/login';
  const String baseUrl = 'https://test001.otecfx.com/api/auth/login';
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode ==  201) {
      // Login successful
      print("Login is now successful with status code ${response.statusCode == 201}");
      print("body is ${response.body}");
      return true;
    } else {
      // Log error message from the server
      final errorData = jsonDecode(response.body);
      print('Login failed: ${errorData['message']}');
      print("this is the failed status code ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print('Error during login: $e');

    return false;
  }
}
