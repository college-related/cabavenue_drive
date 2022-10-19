import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/screens/auth.dart';
import 'package:cabavenue_drive/screens/editscreens/document_edit.dart';
import 'package:cabavenue_drive/screens/editscreens/profile_edit.dart';
import 'package:cabavenue_drive/screens/home.dart';
import 'package:cabavenue_drive/screens/splash_screen.dart';
import 'package:cabavenue_drive/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  /**
   * load .env file
   */
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Cabavenue Driver App',
        theme: AppTheme.main(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/auth': (context) => const AuthPage(),
          '/profile-edit': (context) => const ProfileEditPage(),
          '/document-edit': (context) => const DocumentEdit(),
        },
      ),
    );
  }
}
