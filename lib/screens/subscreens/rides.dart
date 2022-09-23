import 'dart:math';

import 'package:flutter/material.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({Key? key}) : super(key: key);

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final bool _hasRideRequests = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            child: Text('Today', style: Theme.of(context).textTheme.headline1),
          ),
          const Divider(
            color: Colors.grey,
          ),
          !_hasRideRequests
              ? Column(
                  children: [
                    Image.asset(
                      'assets/images/free-time.png',
                      height: 300.0,
                    ),
                    Text(
                      'No Requests',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Enjoy the free time you don\'t have any ride request at the moment',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                )
              : const Text('Rides'),
        ],
      ),
    );
  }
}
