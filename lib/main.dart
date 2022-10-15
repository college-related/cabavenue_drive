import 'package:cabavenue_drive/models/user_model.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/screens/auth.dart';
import 'package:cabavenue_drive/screens/home.dart';
import 'package:cabavenue_drive/screens/splash_screen.dart';
import 'package:cabavenue_drive/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

Future main() async {
  /**
   * load .env file
   */
  await dotenv.load(fileName: ".env");

  /**
   * Add user data from localstorage to provider
   */
  var u = await const FlutterSecureStorage().read(key: "CABAVENUE_USERDATA");
  UserModel user = await UserModel.deserialize(u ?? '{}');

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProfileProvider(user: user)),
      ],
      child: MaterialApp(
        title: 'Cabavenue Driver App',
        theme: AppTheme.main(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/auth': (context) => const AuthPage(),
        },
      ),
    );
  }
}
