import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class ThirdOnboarding extends StatelessWidget {

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
                Image.asset('assets/images/succeed.png'),
                Text(
                  'SUCCEED',
                  style: GoogleFonts.nunito(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Achieve your driving goals and earn your license. We’re with you every step of the way towards becoming a skilled, safe driver.',
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
