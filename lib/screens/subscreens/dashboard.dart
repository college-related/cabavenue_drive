import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _available = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          SwitchListTile(
            title: const Text('Make yourself available'),
            value: _available,
            onChanged: (value) {
              setState(() {
                _available = value;
              });
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            child:
                Text('Dashboard', style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height: 20.0),
          const DashboardDataContainer1(),
          const SizedBox(height: 20.0),
          const DashboardDataContainer2(),
        ],
      ),
    );
  }
}

class DashboardDataContainer1 extends StatelessWidget {
  const DashboardDataContainer1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [
          DashboardDetailRow(title: 'Total Rides', value: '34'),
          DashboardDetailRow(title: 'Total Earnings', value: 'Rs. 13430'),
          DashboardDetailRow(title: 'Overall Rating', value: '4.3'),
        ],
      ),
    );
  }
}

class DashboardDataContainer2 extends StatelessWidget {
  const DashboardDataContainer2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [
          DashboardDetailRow(title: 'Rides today', value: '3'),
          DashboardDetailRow(title: 'Earnings today', value: 'Rs. 1343'),
        ],
      ),
    );
  }
}

class DashboardDetailRow extends StatelessWidget {
  const DashboardDetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}
