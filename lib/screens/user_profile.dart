import 'dart:convert';
import 'package:drive_well/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserTestProfilePage extends StatelessWidget {
  const UserTestProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: currentUser == null
                ? const Center(
              child: Text('Please Login to see your details'),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: const AssetImage(
                      'assets/images/profile_placeholder.png',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User name
                Text(
                  "${currentUser.firstName} ${currentUser.lastName}",
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  '${currentUser.email}',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Profile details section
                _buildProfileDetailItem(Icons.phone, 'Phone Number',
                    currentUser.phoneNumber!),
                const Divider(),

                // Edit Profile button
                ElevatedButton(
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
                    _showEditDialog(context, userProvider);
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Log Out button
                TextButton(
                  onPressed: () {
                    print('the log out button has been clicked');
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build profile detail items
  Widget _buildProfileDetailItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(
        title,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.nunito(),
      ),
    );
  }

  // Function to show the edit dialog
  void _showEditDialog(BuildContext context, UserProvider userProvider) {
    final currentUser = userProvider.currentUser!;

    final TextEditingController addressController =
    TextEditingController(text: currentUser.address);

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
              ),
            ),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Update user details
              final success = await _updateUserDetails(
                userProvider.token,
                addressController.text,
              );

              if (success) {
                userProvider.updateUserDetails(
                  addressController.text
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully')),
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update profile')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Function to send updated user details to the backend
  Future<bool> _updateUserDetails(
      String token,
      String address,
      ) async {
    const String baseUrl = 'https://test001.otecfx.com/api/user/2'; // Replace with your API URL
    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'address' : address

        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating user details: $e');
      return false;
    }
  }
}
