import 'package:cabavenue_drive/pages/auth.dart';
import 'package:cabavenue_drive/pages/home.dart';
import 'package:cabavenue_drive/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cabavenue Driver App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/auth': (context) => const AuthPage(),
        // '/profile':(context) => ProfilePage(),
      },
    );
  }
}
