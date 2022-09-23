import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _readUserData().then(
      (value) => {
        if (value != null)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false)
          }
        else
          {Navigator.of(context).pushNamed('/auth')}
      },
    );
  }

  Future _readUserData() async {
    return await _storage.read(key: "CABAVENUE_USERDATA");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
