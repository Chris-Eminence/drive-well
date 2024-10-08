import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class FirstOnboarding extends StatelessWidget {
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
                Image.asset('assets/images/learn.png'),
                Text(
                  'LEARN',
                  style: GoogleFonts.nunito(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Master the rules of the road with our comprehensive driving lessons, designed to make you confident and well-prepared.',
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
