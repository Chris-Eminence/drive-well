import 'package:drive_well/constants.dart';
import 'package:drive_well/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen/components/bottom_nav.dart';
import 'screens/onboarding_screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: kGreyColor,
        useMaterial3: true,
      ),
      home: BottomNav()
    );
  }
}


// ListView.builder(
// itemCount: lessonItems.length,
// itemBuilder: (context, index) {
// final product = lessonItems[index];
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Material(
// elevation: 5.0, // Set the elevation
// borderRadius: BorderRadius.circular(15.0), // Optional: Add some border radius
// shadowColor: Colors.black.withOpacity(0.5),
// child: Row(
// children: [
// Expanded(
// flex: 1,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(10.0),
// child: Image.asset(
// product.imageUrl, // Use the image URL from the model
// fit: BoxFit.cover,
// ),
// ),
// ),
// const SizedBox(width: 10),
// Expanded(
// flex: 2,
// child: Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// product.title, // Use the title from the model
// style: GoogleFonts.nunito(
// fontWeight: FontWeight.bold,
// fontSize: 16,
// ),
// ),
// Text(
// product.description, // Use the description from the model
// style: GoogleFonts.nunito(fontSize: 14),
// ),
// Text(
// '₦${product.price.toStringAsFixed(2)}/hour', // Use the price from the model
// style: GoogleFonts.nunito(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// color: kPrimaryColor,
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// );
// },
// ),