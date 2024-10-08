import 'package:drive_well/widgets/auth_buttons.dart';
import 'package:drive_well/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String? email;
  String? password;
  String? surname;
  String? firstName;
  String? phoneNumber;
  bool isLoading = false; // Added loading indicator state



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/signup.png'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome 👋',
                      style: GoogleFonts.nunito(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Register',
                      style: GoogleFonts.nunito(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextFields(
                      onChange: (value){
                        surname = value;
                      },
                      hintsText: 'Surname',
                      obscureTexts: false,
                      keyboardTypes: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextFields(
                      onChange: (value){
                        firstName = value;
                      },
                      hintsText: 'Firstname',
                      obscureTexts: false,
                      keyboardTypes: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextFields(
                      onChange: (value){
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
                      onChange: (value){
                        phoneNumber = value;
                      },
                      hintsText: 'Phone number',
                      obscureTexts: false,
                      keyboardTypes: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextFields(
                      onChange: (value){
                        password = value;
                      },
                      hintsText: 'Password',
                      obscureTexts: true,
                      keyboardTypes: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 30),
                    AuthButtons(
                      // onPressed: isLoading ? null : () async => await _register(),
                      buttonText: isLoading
                          ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 153),
                            child: const CircularProgressIndicator(
                              color: Colors.white,

                                                  ),
                          ) // Show circular indicator if loading
                          : Text('Register',  textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(color: Colors.white)),),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?  ',
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login here',
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
        ),
      )),
    );
  }



}




