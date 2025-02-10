
import 'dart:convert';

import 'package:drive_well/repository/registeration_repo.dart';
import 'package:flutter/material.dart';
import '../models/payment_model.dart';
import '../models/user_model.dart';
import '../repository/login_repo.dart';
import '../repository/payment_repo.dart';
import 'package:http/http.dart' as http;


class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  User? _currentUser; // Holds the current user's details
  User? get currentUser => _currentUser; // Getter for accessing the current user

  String? _token; //  Hold the user token
  String get token => _token ?? ''; // getter for accessing the token



  bool _isLoading = false; // Tracks the loading state for async operations
  bool get isLoading => _isLoading;

  String? _errorMessage; // Stores error messages from operations
  String? get errorMessage => _errorMessage;

  int _hoursCounter = 0; // Counter for hours
  int get hoursCounter => _hoursCounter;

  int _initialPrice = 1000; // Initial price per hour
  int get initialPrice => _initialPrice;

  int get finalPrice => _hoursCounter * _initialPrice; // Calculates the final price

  // Tracks if the user is registered
  bool _isRegistered = false;
  bool get isRegistered => _isRegistered;

  // Method to update user details
  void updateUserDetails(String address) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        // Update only the fields provided
        address: address,
      );
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  Future<bool> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String address,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _userService.registerUser(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        address: address,
      );

      if (user != null) {
        _currentUser = user; // Set the registered user as the current user
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to register user.'; // Error if registration fails
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e'; // Handle any exception
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call the login API and get the response
      final response = await loginUserFunction(email, password);

      if (response is Map<String, dynamic> && response['token'] != null) {
        // Extract user details from the response
        final userData = response['user'];

        _currentUser = User(
          email: userData['email'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          phoneNumber: userData['phone_number'],
        );

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to log in: Invalid response.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Clears error messages
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Increment hours counter
  void hoursIncrement() {
    _hoursCounter++;
    notifyListeners();
  }

  // Decrement hours counter
  void hoursDecrement() {
    if (_hoursCounter > 0) {
      _hoursCounter--;
      notifyListeners();
    }
  }

  // For processing payments
  // Future<void> processPayment(Payment payment) async {
  //   try {
  //     await makePayment(payment); // Make the payment
  //     notifyListeners(); // Notify listeners if necessary
  //   } catch (e) {
  //     // Handle any exceptions or log errors
  //     print('Error in processPayment: $e');
  //   }
  // }

  // Function to set the user and token after login or registration
  void setUser(User user, String token) {
    _currentUser = user;
    _token = token;
    notifyListeners();
  }

  // Function to clear user data during logout
  void logout() {
    _currentUser = null;
    _token = null;
    notifyListeners();
  }



}
