import 'package:drive_well/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // Check if the user is logged in
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
        backgroundColor: kPrimaryColor, // Set your preferred color
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
                            'assets/images/profile_placeholder.png', // Replace with user's image
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // User name
                      Text(
                        "${currentUser.firstName} ${currentUser.lastName}",
                        // Replace with dynamic user data
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Email
                      Text(
                        '${currentUser.email}', // Replace with dynamic user data
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
                      // _buildProfileDetailItem(Icons.location_on, 'Address', currentUser.address!),
                      // const Divider(),

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
                          // Handle edit profile action
                          print('Edit Profile button pressed');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('AlertDialog Title'),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'First name',
                                    ),
                                  ),
                                  Divider(),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Last name',
                                    ),
                                  ),
                                  Divider(),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Address',
                                    ),
                                  ),

                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
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
                            color:
                                Colors.red, // Set the color to red for log out
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
}
