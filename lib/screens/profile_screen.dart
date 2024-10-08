import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart'; // Ensure constants are imported

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: AssetImage(
                      'assets/images/profile_placeholder.png', // Replace with user's image
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User name
                Text(
                  'John Doe', // Replace with dynamic user data
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  'johndoe@example.com', // Replace with dynamic user data
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Profile details section
                _buildProfileDetailItem(Icons.phone, 'Phone Number', '+234 800 123 4567'),
                const Divider(),
                _buildProfileDetailItem(Icons.location_on, 'Address', '123 Main Street, Lagos'),
                const Divider(),
                _buildProfileDetailItem(Icons.card_membership, 'Membership', 'Premium'),
                const Divider(),
                _buildProfileDetailItem(Icons.date_range, 'Joined', 'January 2022'),
                const SizedBox(height: 32),

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
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
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
                    // Handle log out action
                    print('Log Out button pressed');
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red, // Set the color to red for log out
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
