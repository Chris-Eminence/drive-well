import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../helper/auth_helper.dart';
import '../screens/authentication_screens/login_screen.dart';

class LogoutPopup extends StatefulWidget {
  const LogoutPopup({super.key});

  @override
  State<LogoutPopup> createState() => _LogoutPopup();
}

class _LogoutPopup extends State<LogoutPopup> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {

                AuthHelper.clearUserCredentials();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
                print('Logout confirmed address');
              }, child: const Text('Confirm', style: TextStyle(color: Colors.white)),
            )),
      ],
    );
  }
}
