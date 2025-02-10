import 'package:drive_well/screens/authentication_screens/registration_screen.dart';
import 'package:drive_well/screens/home_screen/components/bottom_nav.dart';
import 'package:drive_well/screens/home_screen/home_screen.dart';
import 'package:drive_well/widgets/auth_buttons.dart';
import 'package:drive_well/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false; // Added loading indicator state
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter email' : null,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D2445)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D2445)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black54),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D2445)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D2445)),
                        ),
                      ),
                      obscureText: _obscureText,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter password' : null,
                    ),
                    const SizedBox(height: 20),
                    if (userProvider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Center(
                        child: AuthButtons(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await userProvider.loginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNav()),
                                );
                              } else if (userProvider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(userProvider.errorMessage!)),
                                );
                              }
                            }
                          },
                          buttonText: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Text('Login'),
                          ),
                        ),
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
                                        RegistrationScreen()));
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
        ),
      )),
    );
  }
}
