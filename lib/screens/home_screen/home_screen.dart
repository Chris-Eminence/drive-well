import 'package:drive_well/models/lessons_model.dart';
import 'package:drive_well/screens/details_page.dart';
import 'package:drive_well/screens/home_screen/components/carousel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomepageListItems homepageCarousel = HomepageListItems();

  List<LessonsModel> lessonItems = [
    LessonsModel(
      imageUrl: 'assets/images/lessons_ima.jpg',
      lessonName: 'Lesson 1',
      duration: '1 hour',
      amount: 299,
      description: 'This is a description of Product 1.',
    ),

    LessonsModel(
      imageUrl: 'assets/images/lessons_ima.jpg',
      lessonName: 'Lesson 1',
      duration: '1 hour',
      amount: 299,
      description: 'This is a description of Product 1.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print("this is the homepage");
    // UserProvider up = Provider.of<UserProvider>(context);

    // print("this is the user name ${up.user!.firstName}");

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Slider on top
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: homepageCarousel.getCarousels(), // Using the method here
            ),
            const SizedBox(height: 20),

            // Remaining part of the screen
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What we Offer',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Wrap ListView in SizedBox to prevent unbounded height issues
                  InkWell(
                    onTap: () {
                      print('This has been tapped');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage()));
                    },
                    child: SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // Set the rounded edges

                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/lessons_ima.jpg',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    kSecondaryColor.withOpacity(1.0),
                                    kPrimaryColor.withOpacity(0.5),
                                    // Start with a solid color at the bottom
                                    Colors.transparent,
                                    // End with transparent color at the top
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Specialized Driving Lessons',
                                        style: GoogleFonts.nunito(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: kWhiteColor),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: kWhiteColor,
                                      )
                                    ],
                                  ),
                                  Text(
                                    '₦5000/hour',
                                    style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kGreyColor),
                                  ),
                                  Text(
                                    'Specialized Driving Lessons encompasses various types of lessons designed to cater to different skill levels, vehicle types, and driving environments.',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18, color: kGreyColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
