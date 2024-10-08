import 'package:drive_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageListItems {
  List<Widget> getCarousels() {
    return [
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          image: const DecorationImage(
            image: AssetImage('assets/images/carosle1.jpg'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),  // Set the rounded edges

          child: Stack(
            children: [
              // Overlay with color
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Black overlay with opacity
                ),
              ),

              // Content on top of the background
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo (can be replaced with an image if needed)

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      "Learn Fast\nDrive Well",
                      style: GoogleFonts.nunito(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                    // Price and available size

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          image: const DecorationImage(

            image: AssetImage('assets/images/carosel2.jpg'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Overlay with color
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Black overlay with opacity
                ),
              ),

              // Content on top of the background
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo (can be replaced with an image if needed)

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      "Learn at\nYour convenience",
                      style: GoogleFonts.nunito(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                    // Price and available size

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/carosle1.jpg'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Overlay with color
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Black overlay with opacity
                ),
              ),

              // Content on top of the background
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo (can be replaced with an image if needed)

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      "Chose your\nOwn time",
                      style: GoogleFonts.nunito(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                    // Price and available size

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  // Function to return a list of three identical containers
  List<Widget> getVideoItems() {
    return List<Widget>.generate(10, (index) {
      return Card(
          elevation: 5,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset('assets/images/lessons_im.jpg'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Automatic Transmission',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Basic Driving Skills',
                        style: GoogleFonts.nunito(fontSize: 14),
                      ),
                      Text(
                        '₦2500/hour',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }
}
