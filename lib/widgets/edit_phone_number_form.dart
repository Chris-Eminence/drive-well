import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class EditPhoneNumberForm extends StatefulWidget {
  const EditPhoneNumberForm({super.key});

  @override
  State<EditPhoneNumberForm> createState() => _EditPhoneNumberFormState();
}

class _EditPhoneNumberFormState extends State<EditPhoneNumberForm> {
  final TextEditingController _textController = TextEditingController();

  int? _userId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('user_id'); // Ensure key matches stored preference
    });
  }

  Future<void> _updateAddress() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found!")),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://careerconnects.us/api/user/$_userId';
    final Map<String, dynamic> data = {'phone_number': _textController.text};

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Phone number updated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update address: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _textController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter Address",
          ),
        ),
        const SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                print('Update address');
                _updateAddress();
                // pop the dialog

              }, child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Update Address', style: TextStyle(color: Colors.white)),
            )),
      ],
    );
  }
}
