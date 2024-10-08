import 'package:drive_well/screens/authentication_screens/registration_screen.dart';
import 'package:drive_well/screens/home_screen/home_screen.dart';
import 'package:drive_well/widgets/auth_buttons.dart';
import 'package:drive_well/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false; // Added loading indicator state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/login.png'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back 😁',
                    style: GoogleFonts.nunito(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextFields(
                    onChange: (value) {
                      email = value;
                    },
                    hintsText: 'Email address',
                    obscureTexts: false,
                    keyboardTypes: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextFields(
                    onChange: (value) {
                      password = value;
                    },
                    hintsText: 'Password',
                    obscureTexts: true,
                    keyboardTypes: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 30),
                  AuthButtons(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Homepage()));
                    },
                    buttonText: isLoading
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 153),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            )) // Show circular indicator if loading
                        : Text('Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(color: Colors.white)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?  ',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen()));
                        },
                        child: Text(
                          'Register here',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
