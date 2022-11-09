import 'package:cabavenue_drive/models/ride_model.dart';
import 'package:cabavenue_drive/providers/disable_provider.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:cabavenue_drive/services/notification_service.dart';
import 'package:cabavenue_drive/services/ride_service.dart';
import 'package:cabavenue_drive/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({Key? key}) : super(key: key);

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    if (Provider.of<RideRequestProvider>(context, listen: false)
            .getRideRequestListData
            .isEmpty &&
        !Provider.of<DisableProvider>(context, listen: false).getIsDisabled) {
      RideModel.getRequestRides(context, filter: "newOnly");
    }
  }

  Future<void> _refreshRides() async {
    Provider.of<RideRequestProvider>(context, listen: false)
        .setIsFetching(true);
    RideModel.getRequestRides(context, filter: "newOnly");
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: _refreshRides,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 5.0),
                  child: Text('Today',
                      style: Theme.of(context).textTheme.headline1),
                ),
                Consumer<RideRequestProvider>(
                  builder: ((context, value, child) {
                    if (value.getIsRideRequestFetching) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (value.getRideRequestListData.isEmpty) {
                      return Column(
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
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          itemCount: value.getRideRequestListData.length,
                          itemBuilder: (context, index) {
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
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 6.0),
                                            child: Icon(Iconsax.location,
                                                size: 20.0),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pickup point',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(value
                                                    .getRideRequestListData[
                                                        index]
                                                    .source['name']),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 6.0),
                                            child: Icon(Iconsax.location,
                                                size: 20.0),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Destination',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(value
                                                    .getRideRequestListData[
                                                        index]
                                                    .destination['name']),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        Moment(DateTime.parse(value
                                                .getRideRequestListData[index]
                                                .createdAt))
                                            .fromNow(
                                                form: UnitStringForm.short),
                                      ),
                                      Text(
                                        "Rs. ${num.parse(value.getRideRequestListData[index].price.toString()).toStringAsFixed(2)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            iconSize: 50.0,
                                            color: Colors.teal,
                                            onPressed: () {
                                              showAlertDialog(
                                                context,
                                                value.getRideRequestListData[
                                                    index],
                                                index,
                                                "confirm",
                                              );
                                            },
                                            icon:
                                                const Icon(Iconsax.tick_circle),
                                          ),
                                          IconButton(
                                            iconSize: 50.0,
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              showAlertDialog(
                                                context,
                                                value.getRideRequestListData[
                                                    index],
                                                index,
                                                "reject",
                                              );
                                            },
                                            icon: const Icon(
                                                Iconsax.close_circle),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// show alert dialouge for confirmation of request rides
showAlertDialog(BuildContext context, RideModel request, int index, type) {
  // Create yes button
  Widget yesButton = ElevatedButton(
    onPressed: () {
      if (type == 'confirm') {
        RideService().acceptRequest(context, request.id);
        NotificationService().sendRideRequestNotification(
          context,
          request.passenger,
          "Request Accepted",
          "Your Request has been accepted",
        );
        Provider.of<ProfileProvider>(context, listen: false).setInRide(true);
        UserService().setInRide(true);
        Provider.of<RideRequestProvider>(context, listen: false)
            .setRideIndex(index);
        Navigator.of(context).popAndPushNamed('/inRide');
      } else {
        RideService().rejectRequest(context, request.id);
        NotificationService().sendRideRequestNotification(
          context,
          request.passenger,
          "Request Cancelled",
          "Your Request has been cancelled",
        );
        Provider.of<RideRequestProvider>(context, listen: false)
            .removeRideRequestFromList(index);
        Navigator.of(context).pop();
      }
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    child: const Text("YES"),
  );

//  Create cancel button
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text("Cancel"),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: type == 'confirm'
        ? const Text("Confirm the ride?")
        : const Text("Reject the ride?"),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: type == 'confirm'
            ? const Text('You are going to accept this request!')
            : const Text('You are going to reject this request!'),
      ),
    ),
    actions: [
      cancelButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: ((context, setState) {
        setState(() {});
        return alert;
      }));
    },
  );
}
