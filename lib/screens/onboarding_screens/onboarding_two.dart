import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants.dart';

class SecondOnboarding extends StatelessWidget {

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(''),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/drive.png'),
                Text(
                  'DRIVE',
                  style: GoogleFonts.nunito(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Experience hands-on training with real-time feedback, helping you gain the skills needed to navigate any road with ease.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        color: kPrimaryColor,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
