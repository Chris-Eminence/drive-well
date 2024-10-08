import 'package:drive_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButtons extends StatelessWidget {
   AuthButtons({this.buttonText, this.primaryColor = const Color(0xFFAAC527), this.onPressed});

  final Widget? buttonText;
  final Function()? onPressed;
  Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: buttonText,
            // textAlign: TextAlign.center,
            // style: GoogleFonts.nunito(color: Colors.white)),
      ),
    );
  }
}