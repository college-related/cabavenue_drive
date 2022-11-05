import 'package:cabavenue_drive/screens/ridesubscreens/current_ride.dart';
import 'package:cabavenue_drive/screens/ridesubscreens/current_ride_map.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';

class InRidePage extends StatefulWidget {
  const InRidePage({Key? key}) : super(key: key);

  @override
  State<InRidePage> createState() => _InRidePageState();
}

class _InRidePageState extends State<InRidePage> {
  int _currentIndex = 0;
  final List _pages = const [
    CurrentRideScreen(),
    CurrentRideMapScreen(),
  ];
  final List _pageTitle = <String>[
    'Current Ride',
    'Map',
  ];

  @override
  void initState() {
    super.initState();
  }

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
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: CustomNavigationBar(
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.car),
              selectedIcon: const Icon(Iconsax.car5),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.map_1),
              selectedIcon: const Icon(Iconsax.map5),
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
    Fluttertoast.showToast(
      msg: 'Finish the ride first',
      backgroundColor: Colors.red[400],
    );
    return Future.value(false);
  }
}
