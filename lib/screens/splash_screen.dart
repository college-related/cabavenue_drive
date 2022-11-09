import 'dart:convert';

import 'package:cabavenue_drive/models/ride_model.dart';
import 'package:cabavenue_drive/providers/disable_provider.dart';
import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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
    if (!Provider.of<DisableProvider>(context, listen: false).getIsDisabled) {
      _readUserData().then((value) {
        if (value == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/auth', (route) => false);
        } else {
          if (jsonDecode(value)["isInRide"]) {
            RideModel.getRequestRides(context, filter: "onlyNew").then((ride) {
              List<RideModel> rides =
                  Provider.of<RideRequestProvider>(context, listen: false)
                      .getRideRequestListData;
              List<bool> indexArr = [];
              for (var i = 0; i < rides.length; i++) {
                if (rides[i].status == 'accepted') {
                  indexArr.add(true);
                } else {
                  indexArr.add(false);
                }
              }
              Provider.of<RideRequestProvider>(context, listen: false)
                  .setRideIndex(indexArr.indexOf(true));
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/inRide', (route) => false);
            });
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          }
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        child: Image(
          image: AssetImage('assets/images/location-style-1-rounded.jpg'),
        ),
      ),
    );
  }
}
