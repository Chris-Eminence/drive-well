import 'package:drive_well/repository/registeration_repo.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/login_repo.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
      final success = await loginUserFunction(email, password);
      if (success) {
        // Optionally set the current user if you have user details
        _currentUser = User(email: email); // Update if more fields are needed
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to log in.';
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



}
