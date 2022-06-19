import 'package:cabavenue_drive/pages/home.dart';
import 'package:cabavenue_drive/pages/signup_login.dart';
import 'package:flutter/material.dart';

void main(){
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
        '/':(context) => const MyHomePage(),
        '/signup-login':(context) => const SignupLogin(),
        // '/profile':(context) => ProfilePage(),
      },
    );
  }
}