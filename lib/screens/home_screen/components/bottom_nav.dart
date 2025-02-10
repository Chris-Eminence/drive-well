import 'package:drive_well/constants.dart';
import 'package:drive_well/screens/history_page.dart';
import 'package:drive_well/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../../user_profile.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // This is to keep track of the selected index in the BottomNavigationBar
  int _currentIndex = 0;

  // List of widgets for each screen
  final List<Widget> _screens = [
    const Center(child: Homepage()),
    Center(child: HistoryScreen()),
    const Center(child: ProfilePage()),
  ];

  // Function to handle tap on BottomNavigationBar items
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drive Well'),
      ),
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex, // Set the currently selected index
        onTap: _onItemTapped, // Handle tap on items
        selectedItemColor: kPrimaryColor, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
      ),
    );
  }
}