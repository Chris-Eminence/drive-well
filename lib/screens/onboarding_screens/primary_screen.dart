import 'package:drive_well/constants.dart';
import 'package:drive_well/screens/authentication_screens/login_screen.dart';
import 'package:drive_well/screens/onboarding_screens/onboarding_one.dart';
import 'package:drive_well/screens/onboarding_screens/onboarding_three.dart';
import 'package:drive_well/screens/onboarding_screens/onboarding_two.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PrimaryOnboardingScreen extends StatefulWidget {
  const PrimaryOnboardingScreen({super.key});

  @override
  State<PrimaryOnboardingScreen> createState() =>
      _PrimaryOnboardingScreenState();
}

class _PrimaryOnboardingScreenState extends State<PrimaryOnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  DotDecoration _decoration = DotDecoration();
  int activePage = 0;

  final List<Widget> pages = [
    Container(
      color: Colors.transparent,
      child: FirstOnboarding(),
    ),
    Container(
      color: Colors.transparent,
      child: SecondOnboarding(),
    ),
    Container(
      color: Colors.transparent,
      child: ThirdOnboarding(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onchanged(int index) {
    setState(() {
      activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onchanged,
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, int index) {
                return pages[index];
              },
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: screenWidth,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          List<Widget>.generate(pages.length, (int index) {
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 12,
                            width: (index == activePage) ? 30 : 10,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (index == activePage)
                                    ? kSecondaryColor
                                    : Colors.orange));
                      })),
                  InkWell(
                    onTap: () {
                      if (activePage == pages.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      } else {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOutQuint);
                      }
                    },
                    child: AnimatedContainer(
                      // alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      height: screenHeight / 26.9,
                      width: (activePage == (pages.length - 1)) ? 200 : 75,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60)),
                      child: (activePage == (pages.length - 1))
                          ? Text(
                              "Continue",
                              style: GoogleFonts.nunito(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.end,
                            )
                          : Icon(
                              Icons.keyboard_double_arrow_right,
                              size: 30,
                              color: kSecondaryColor,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
