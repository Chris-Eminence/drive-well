import 'package:drive_well/repository/registeration_repo.dart';
import 'package:flutter/material.dart';
import '../models/payment_model.dart';
import '../models/user_model.dart';
import '../repository/login_repo.dart';
import '../repository/payment_repo.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _hoursCounter = 0;
  int get hoursCounter => _hoursCounter;

  int _initialPrice = 5000;
  int get initialPrice => _initialPrice;

  int get finalPrice => _hoursCounter * _initialPrice;


  Future<bool> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async
  {
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
      );

      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to register user.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
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


  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void hoursIncrement(){
    _hoursCounter ++;
    notifyListeners();
  }
  void hoursDecrement(){
    if(_hoursCounter > 0) {
      _hoursCounter--;
      notifyListeners();
    }
  }


// FOR MAKING PAYMENTS

  Future<void> processPayment(Payment payment) async {
    try {
      await makePayment(payment);
      // Notify listeners if you need to update UI or state

      notifyListeners();
    } catch (e) {
      // Handle any exceptions or log errors
      print('Error in processPayment: $e');
    }
  }

}
