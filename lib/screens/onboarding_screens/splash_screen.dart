import 'dart:async';

import 'package:drive_well/screens/onboarding_screens/primary_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:drive_well/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PrimaryOnboardingScreen()),
      );
    });
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
                  delay: Duration(seconds: 2)),
              child: Image.asset(
                'assets/images/splash_icon.png', // Replace with your image path
              ),
            ),
            SizedBox(height: 20),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                  delay: Duration(seconds: 2)),
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
                  Text('Affordable & Reliable',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: kOrangeColor,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

