import 'package:cabavenue_drive/models/ride_model.dart';
import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:cabavenue_drive/screens/subscreens/dashboard.dart';
import 'package:cabavenue_drive/screens/subscreens/profile.dart';
import 'package:cabavenue_drive/screens/subscreens/rides.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

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
    ProfileScreen(),
  ];
  final List _pageTitle = <String>[
    'Home',
    'Rides',
    'Profile',
  ];

  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(message);
    });
  }

  handleNotification(RemoteMessage message) async {
    if (message.notification!.title == 'Rating') {
      Fluttertoast.showToast(
        msg: 'You got a rating from recent ride',
        backgroundColor: Colors.green[500],
      );
      return;
    }
    if (message.notification!.title == 'Ride request cancel') {
      Fluttertoast.showToast(
        msg: 'A ride request has been cancelled',
        backgroundColor: Colors.red[500],
      );
    } else {
      Fluttertoast.showToast(
        msg: 'New ride request',
        backgroundColor: Colors.green[500],
      );
    }
    RideModel.getRequestRides(context, filter: "onlyNew");
    setState(() {
      _currentIndex = 1;
    });
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
              icon: const Icon(Iconsax.home),
              selectedIcon: const Icon(Iconsax.home_15),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.smart_car),
              selectedIcon: const Icon(Iconsax.smart_car5),
              showBadge: Provider.of<RideRequestProvider>(context)
                  .getRideRequestListData
                  .isNotEmpty,
              badgeCount: Provider.of<RideRequestProvider>(context)
                  .getRideRequestListData
                  .length,
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
