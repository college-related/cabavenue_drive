import 'dart:convert';

import 'package:cabavenue_drive/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user;

  @override
  void initState() {
    super.initState();
    _readUserData();
  }

  Future<void> _readUserData() async {
    var u = await const FlutterSecureStorage().read(key: "CABAVENUE_USERDATA");
    print(jsonEncode(u));
    setState(() {
      user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
              image: AssetImage('assets/images/location-style-1-rounded.jpg')),
          const Text(
            'Cabavenue',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          ),
          Text(
            '$user',
          ),
          // Text('Drive', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey),),
          SizedBox(
              // width: MediaQuery.of(context).size.width,
              child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                side: const BorderSide(color: Colors.blue),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                elevation: 10,
              ),
              onPressed: () {
                AuthService().logout();
                Navigator.of(context).pushNamed('/auth');
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
