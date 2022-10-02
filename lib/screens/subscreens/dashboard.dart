import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                DashboardDataContainer(
                  color: Color(0xffC9B6E9),
                  value: '34',
                  title: 'Total Rides',
                  icon: Iconsax.driving,
                ),
                SizedBox(width: 20.0),
                DashboardDataContainer(
                  color: Color(0xffD0EAF9),
                  value: 'Rs. 13450',
                  title: 'Total Earnings',
                  icon: Iconsax.money_recive,
                ),
                SizedBox(width: 20.0),
                DashboardDataContainer(
                  color: Color(0xffB3E1D7),
                  value: '4.3',
                  title: 'Ratings',
                  icon: Iconsax.star,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            child: Text('Today', style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                DashboardDataContainer(
                  color: Color(0xffFDE7B2),
                  value: '3',
                  title: 'Total Rides',
                  icon: Iconsax.driving,
                ),
                SizedBox(width: 20.0),
                DashboardDataContainer(
                  color: Color(0xffF8A8A9),
                  value: 'Rs. 1340',
                  title: 'Total Earnings',
                  icon: Iconsax.money_recive,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

class DashboardDataContainer extends StatelessWidget {
  const DashboardDataContainer({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
    required this.color,
  }) : super(key: key);

  final String value;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 50.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
