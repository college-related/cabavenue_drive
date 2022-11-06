import 'package:cabavenue_drive/providers/device_provider.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:cabavenue_drive/screens/auth.dart';
import 'package:cabavenue_drive/screens/editscreens/document_edit.dart';
import 'package:cabavenue_drive/screens/editscreens/profile_edit.dart';
import 'package:cabavenue_drive/screens/home.dart';
import 'package:cabavenue_drive/screens/in_ride.dart';
import 'package:cabavenue_drive/screens/ride_history.dart';
import 'package:cabavenue_drive/screens/splash_screen.dart';
import 'package:cabavenue_drive/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider(context)),
        ChangeNotifierProvider(create: (context) => RideRequestProvider()),
      ],
      child: MaterialApp(
        title: 'Cabavenue Driver App',
        theme: AppTheme.main(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Consumer<DeviceProvider>(
                builder: (context, value, child) => const SplashScreen(),
              ),
          '/home': (context) => const HomePage(),
          '/auth': (context) => const AuthPage(),
          '/profile-edit': (context) => const ProfileEditPage(),
          '/document-edit': (context) => const DocumentEdit(),
          '/history': (context) => const RideHistory(),
          '/inRide': (context) => const InRidePage(),
        },
      ),
    );
  }
}
