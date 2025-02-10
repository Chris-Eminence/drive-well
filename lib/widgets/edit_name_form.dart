import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class EditNameForm extends StatefulWidget {
  const EditNameForm({super.key});

  @override
  State<EditNameForm> createState() => _EditNameFormState();
}

class _EditNameFormState extends State<EditNameForm> {
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _surnameTextController = TextEditingController();

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

  Future<void> _updateName() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found!")),
      );
      return;
    }

    // Prepare data for update (only send non-empty fields)
    final Map<String, dynamic> data = {};
    if (_firstNameTextController.text.isNotEmpty) {
      data['first_name'] = _firstNameTextController.text;
    }
    if (_surnameTextController.text.isNotEmpty) {
      data['last_name'] = _surnameTextController.text;
    }

    // If no fields were changed, show a message and return
    if (data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter at least one name field to update.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final String apiUrl = 'https://careerconnects.us/api/user/$_userId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Name updated successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update name: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
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
          controller: _firstNameTextController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "First Name",
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _surnameTextController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Last Name",
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
            onPressed: _updateName,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              'Update Name',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
