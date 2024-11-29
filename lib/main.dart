import 'package:drive_well/provider/user_provider.dart';
import 'package:drive_well/screens/authentication_screens/login_screen.dart';
import 'package:drive_well/screens/authentication_screens/registration_screen.dart';
import 'package:drive_well/screens/onboarding_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
