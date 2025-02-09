import 'dart:async';
import 'package:drive_well/screens/onboarding_screens/primary_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:drive_well/constants.dart';
import 'package:flutter/material.dart';

import '../../helper/auth_helper.dart';
import '../home_screen/components/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for the splash screen animation duration
    await Future.delayed(Duration(seconds: 1));

    // Check if the user is logged in (i.e., token and ID exist)
    final isLoggedIn = await AuthHelper.isLoggedIn();
    print('Is logged in: $isLoggedIn'); // Debug log


    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => isLoggedIn
                ? BottomNav()
                : const PrimaryOnboardingScreen())); // Replace with your home screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
                delay: Duration(seconds: 2),
              ),
              child: Image.asset(
                'assets/images/splash_icon.png', // Replace with your image path
              ),
            ),
            SizedBox(height: 20),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                delay: Duration(seconds: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'DRIVE WELL',
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Affordable & Reliable',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: kOrangeColor,
                      fontWeight: FontWeight.bold,
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
