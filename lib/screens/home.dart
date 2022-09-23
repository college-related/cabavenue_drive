import 'package:cabavenue_drive/screens/subscreens/dashboard.dart';
import 'package:cabavenue_drive/screens/subscreens/map.dart';
import 'package:cabavenue_drive/screens/subscreens/profile.dart';
import 'package:cabavenue_drive/screens/subscreens/rides.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List _pages = const [
    DashboardScreen(),
    RideScreen(),
    MapScreen(),
    ProfileScreen(),
  ];
  final List _pageTitle = <String>[
    'Home',
    'Rides',
    'Map',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle[_currentIndex]),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        toolbarHeight: 70.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _pages[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Iconsax.home),
            // title: const Text('Home'),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Iconsax.smart_car),
            // title: const Text('Rides'),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Iconsax.map),
            // title: const Text('Map'),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Iconsax.user_tag),
            // title: const Text('Profile'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => {_currentIndex = index}),
        elevation: 12.0,
        selectedColor: const Color(0xff040307),
        strokeColor: const Color(0x30040307),
      ),
    );
  }
}