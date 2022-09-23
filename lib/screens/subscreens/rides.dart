import 'package:flutter/material.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({Key? key}) : super(key: key);

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Rides'),
        const Text('No Rides'),
      ],
    );
  }
}
