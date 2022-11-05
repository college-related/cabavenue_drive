import 'package:cabavenue_drive/models/dashboard_model.dart';
import 'package:cabavenue_drive/services/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<DashboardModel> dashReport;
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<DashboardModel> getDashReport(BuildContext context) async {
    var data = await DashboardService().getDashboardReport(context);
    return DashboardModel.deserialize(data.toString());
  }

  @override
  void initState() {
    super.initState();
    dashReport = getDashReport(context);
  }

  Future<void> _refreshDashboard() async {
    setState(() {
      dashReport = getDashReport(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      showChildOpacityTransition: false,
      onRefresh: _refreshDashboard,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
        child: SingleChildScrollView(
          child: FutureBuilder<DashboardModel>(
            future: dashReport,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5.0),
                      child: Text('Dashboard',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 250.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          DashboardDataContainer(
                            color: const Color(0xffC9B6E9),
                            value: snapshot.data!.totalRides.toString(),
                            title: 'Total Rides',
                            icon: Iconsax.driving,
                          ),
                          const SizedBox(width: 20.0),
                          DashboardDataContainer(
                            color: const Color(0xffD0EAF9),
                            value:
                                'Rs. ${snapshot.data!.totalEarnings.toString()}',
                            title: 'Total Earnings',
                            icon: Iconsax.money_recive,
                          ),
                          const SizedBox(width: 20.0),
                          DashboardDataContainer(
                            color: const Color(0xffB3E1D7),
                            value: snapshot.data!.totalRating.toString(),
                            title: 'Ratings',
                            icon: Iconsax.star,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5.0),
                      child: Text('Today',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 250.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          DashboardDataContainer(
                            color: const Color(0xffFDE7B2),
                            value: snapshot.data!.totalsToday['totalRides']
                                .toString(),
                            title: 'Total Rides',
                            icon: Iconsax.driving,
                          ),
                          const SizedBox(width: 20.0),
                          DashboardDataContainer(
                            color: const Color(0xffF8A8A9),
                            value:
                                'Rs. ${snapshot.data!.totalsToday["totalEarnings"].toString()}',
                            title: 'Total Earnings',
                            icon: Iconsax.money_recive,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                );
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
        ),
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
