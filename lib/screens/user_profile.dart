import 'dart:convert';
import 'package:drive_well/widgets/edit_name_form.dart';
import 'package:drive_well/widgets/logout_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/edit_phone_number_form.dart';
import '../widgets/edit_address_form.dart';

import 'dart:async';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final StreamController<Map<String, dynamic>?> _userStreamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _startUserStream();
  }

  @override
  void dispose() {
    _userStreamController.close();
    super.dispose();
  }

  void _startUserStream() {
    Stream.periodic(const Duration(seconds: 3)).listen((_) async {
      final userData = await _fetchUserDetails();
      _userStreamController.add(userData);
    });
  }

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId == null) {
      print("No user ID found. User might be logged out.");
      return null;
    }

    final Uri url =
        Uri.parse("https://careerconnects.us/api/user/$userId/data");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['user'];
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return null;
    }
  }

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
        backgroundColor: kPrimaryColor,

      ),
      body: SafeArea(
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: _userStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final userDetails = snapshot.data;

            if (userDetails == null) {
              return const Center(child: Text("Failed to load user details."));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${userDetails['first_name']} ${userDetails['last_name']}",
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.drive_file_rename_outline, size: 15,),
                            onPressed: () {
                              print('Edit name clicked');
                              _showDialog(context, 'Update Name', const EditNameForm());
                            },
                          ),
                        ],
                      ),
                      SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${userDetails['email']}",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildProfileDetailItem(
                    Icons.phone,
                    'Phone Number',
                    "${userDetails['phone_number']}",
                    () {
                      print('Edit phone number clicked');
                      _showDialog(context, 'Update Phone Number', const EditPhoneNumberForm());

                    },
                    Icons.drive_file_rename_outline,
                  ),
                  _buildProfileDetailItem(
                    Icons.location_on_outlined,
                    'Home Address',
                    userDetails['address']?.toString() ?? 'Not specified',
                    () {
                      print('Edit address clicked');
                      _showDialog(context, 'Update Address', const EditAddressForm());
                    },
                    Icons.drive_file_rename_outline,
                  ),
                  const SizedBox(height: 24),
                  const Divider(),

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      _showDialog(context, "", LogoutPopup());
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileDetailItem(
    IconData icon,
    String title,
    String subtitle,
    Function() onClick,
    IconData editIcon,
  ) {
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
      trailing: IconButton(
        icon: Icon(editIcon),
        onPressed: onClick
      ),
    );
  }

  void _showDialog(BuildContext context, String title, Widget content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   Map<String, dynamic>? userDetails;
//
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserDetails();
//   }
//
//   void _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Update Address"),
//           content: const EditProfileForm(),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> fetchUserDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     int? userId = prefs.getInt('user_id'); // Retrieve user_id
//     print("this current user id is: $userId");
//
//     if (userId == null) {
//       print("No user ID found. User might be logged out.");
//       setState(() => isLoading = false);
//       return;
//     }
//
//     final Uri url = Uri.parse(
//         "https://careerconnects.us/api/user/$userId/data"); // Use user ID
//
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         setState(() {
//           userDetails = data['user'];
//           isLoading = false;
//         });
//       } else {
//         print("Error: ${response.statusCode} - ${response.body}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Exception occurred: $e");
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Profile',
//           style: GoogleFonts.nunito(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         backgroundColor: kPrimaryColor,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : userDetails != null
//                     ? Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Profile picture
//                           Center(
//                             child: CircleAvatar(
//                               radius: 60,
//                               backgroundColor: Colors.grey.shade200,
//                               backgroundImage: const AssetImage(
//                                 'assets/images/profile_placeholder.png',
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//
//                           // User name
//                           Text(
//                             "${userDetails!['first_name']} ${userDetails!['last_name']}",
//                             style: GoogleFonts.nunito(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Email
//                           Text(
//                             "${userDetails!['email']}",
//                             style: GoogleFonts.nunito(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Profile details section
//                           _buildProfileDetailItem(
//                             Icons.phone,
//                             'Phone Number',
//                             "${userDetails!['phone_number']}",
//                           ),
//                           // Profile details section
//                           _buildProfileDetailItem(
//                             Icons.location_on_outlined,
//                             'Home Address',
//                             userDetails?['address']?.toString() ??
//                                 'Not specified',
//                           ),
//                           const SizedBox(height: 24),
//                           const Divider(),
//
//                           // Edit Profile button
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: kPrimaryColor,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 16.0,
//                                 horizontal: 5.0,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             onPressed: () {
//                               print('Edit Profile button clicked');
//                               _showDialog(context);
//                             },
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 100.0),
//                               child: Text(
//                                 'Edit Profile',
//                                 style: GoogleFonts.nunito(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//
//                           // Log Out button
//                           TextButton(
//                             onPressed: () {
//                               print('the log out button has been clicked');
//                               AuthHelper.clearUserCredentials();
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const LoginScreen()));
//                             },
//                             child: Text(
//                               'Log Out',
//                               style: GoogleFonts.nunito(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : const Center(child: Text("Failed to load user details.")),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper method to build profile detail items
//   Widget _buildProfileDetailItem(IconData icon, String title, String subtitle) {
//     return ListTile(
//       leading: Icon(icon, color: kPrimaryColor),
//       title: Text(
//         title,
//         style: GoogleFonts.nunito(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: GoogleFonts.nunito(),
//       ),
//     );
//   }
//
//   // Function to show the edit dialog
//   void _showEditDialog(BuildContext context, UserProvider userProvider) {
//     final currentUser = userProvider.currentUser!;
//
//     final TextEditingController addressController =
//         TextEditingController(text: currentUser.address);
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Edit Profile'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: addressController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'First Name',
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               // Update user details
//               final success = await _updateUserDetails(
//                 userProvider.token,
//                 addressController.text,
//               );
//
//               if (success) {
//                 userProvider.updateUserDetails(addressController.text);
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Profile updated successfully')),
//                 );
//               } else {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Failed to update profile')),
//                 );
//               }
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Function to send updated user details to the backend
//   Future<bool> _updateUserDetails(
//     String token,
//     String address,
//   ) async {
//     const String baseUrl =
//         'https://test001.otecfx.com/api/user/2'; // Replace with your API URL
//     try {
//       final response = await http.put(
//         Uri.parse(baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({'address': address}),
//       );
//
//       return response.statusCode == 200;
//     } catch (e) {
//       print('Error updating user details: $e');
//       return false;
//     }
//   }
// }
