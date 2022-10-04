import 'package:cabavenue_drive/screens/subscreens/dashboard.dart';
import 'package:cabavenue_drive/screens/subscreens/map.dart';
import 'package:cabavenue_drive/screens/subscreens/profile.dart';
import 'package:cabavenue_drive/screens/subscreens/rides.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _pageTitle[_currentIndex],
            style: Theme.of(context).textTheme.headline3,
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 70.0,
          elevation: 1,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
            child: _pages[_currentIndex],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.home),
              selectedIcon: const Icon(Iconsax.home_15),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.smart_car),
              selectedIcon: const Icon(Iconsax.smart_car5),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.map),
              selectedIcon: const Icon(Iconsax.map_15),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.personalcard),
              selectedIcon: const Icon(Iconsax.personalcard5),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => {_currentIndex = index}),
          elevation: 0.0,
          selectedColor: const Color(0xff75A99B),
          strokeColor: const Color(0xff75A99B),
          unSelectedColor: Colors.black54,
          backgroundColor: Colors.white,
          iconSize: 28.0,
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Click again to exit the app");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
