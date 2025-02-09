import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthHelper {
  static const String _tokenKey = 'user_token';
  static const String _userIdKey = 'user_id';

  // Save the user's token and ID
  static Future<void> saveUserCredentials(String token, int userId) async {
    print("saveUserCredentials has been called");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_userIdKey, userId);
    print("saveUserCredentials has executed successfully");
  }

  // Get the user's token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get the user's ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  // Check if the user is logged in (i.e., token and ID exist)
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null &&
        prefs.getInt(_userIdKey) != null;
  }

  // Clear the user's token and ID (e.g., on sign-out)
  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }

  // Fetch user details from API
  static Future<Map<String, dynamic>?> fetchUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);

    if (token == null) {
      print("No token found. User might be logged out.");
      return null;
    }

    final Uri url = Uri.parse("https://careerconnects.us/api/user/data");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['user']; // Returning only user data
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return null;
    }
  }

}