import 'package:cabavenue_drive/screens/auth.dart';
import 'package:cabavenue_drive/screens/home.dart';
import 'package:cabavenue_drive/screens/splash_screen.dart';
import 'package:cabavenue_drive/utils/theme.dart';
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
      theme: AppTheme.main(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/auth': (context) => const AuthPage(),
      },
    );
  }
}
