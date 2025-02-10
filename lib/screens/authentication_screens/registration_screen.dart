import 'package:drive_well/provider/user_provider.dart';
import 'package:drive_well/screens/authentication_screens/login_screen.dart';
import 'package:drive_well/screens/home_screen/components/bottom_nav.dart';
import 'package:drive_well/widgets/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText2 = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  } void _togglePassword2Visibility() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/signup.png'),
                Text(
                  textAlign: TextAlign.start,
                  'Welcome 👋',
                  style: GoogleFonts.nunito(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.start,
                  'Register',
                  style: GoogleFonts.nunito(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter first name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last name',
                    labelStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter last name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) => value!.isEmpty ? 'Enter email' : null,
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
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    labelStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter phone number' : null,
                ),
                const SizedBox(height: 20),
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
                TextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: _togglePassword2Visibility,
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.black54),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1D2445)),
                    ),
                  ),
                  obscureText: _obscureText2,
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 20),
                if (userProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Center(
                    child: AuthButtons(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await userProvider.registerUser(
                            email: _emailController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            address: _addressController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );

                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          } else if (userProvider.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(userProvider.errorMessage!)),
                            );
                          }
                        }
                      },
                      buttonText: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                        child: Text('Register'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
