import 'package:drive_well/provider/user_provider.dart';
import 'package:drive_well/screens/check_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drive_well/constants.dart';
import 'package:provider/provider.dart';

import '../widgets/description.dart'; // Ensure constants are imported

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      floatingActionButton: userProvider.hoursCounter > 0
    ? FloatingActionButton.extended(
    backgroundColor: kPrimaryColor, // Set your preferred color
      onPressed: () {
        // Handle continue action
        print('Continue button pressed');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
      },
      label: Text(
        "₦${userProvider.finalPrice} Continue",
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Ensure the text color contrasts the background
        ),
      ),
    )
        : null, // FAB disappears when numberOfHours is 0
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Image section
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      'assets/images/lessons_ima.jpg',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Back button and menu button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price row
                    Text(
                      'Specialized Driving Lessons',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text( userProvider.initialPrice > 5000 ?
                      '₦${userProvider.finalPrice }/hour' : '₦${userProvider.initialPrice }',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Hours selection row
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                userProvider.hoursDecrement();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: userProvider.hoursCounter <= 0
                                      ? Colors.grey
                                      : kPrimaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: GoogleFonts.nunito(
                                      fontSize: 32,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              userProvider.hoursCounter.toString(),
                              style: GoogleFonts.nunito(
                                  fontSize: 32,
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Hours",
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: InkWell(
                              onTap: () {
                                userProvider.hoursIncrement();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: GoogleFonts.nunito(
                                      fontSize: 32,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Description title
                    Text(
                      'Description',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // List of driving lessons
                    SizedBox(
                      height: 400, // Define a fixed height
                      child: ListView.builder(
                        itemCount: drivingLessons.length,
                        itemBuilder: (context, index) {
                          final lesson = drivingLessons[index];
                          return ListTile(
                            title: Text(
                              lesson['title'],
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              lesson['overview'],
                              style: GoogleFonts.nunito(),
                            ),
                            onTap: () {
                              // Navigate to detail page or show more info
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 74), // Add spacing to avoid FAB overlap
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
