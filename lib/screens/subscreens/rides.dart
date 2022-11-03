import 'dart:convert';

import 'package:cabavenue_drive/models/ride_model.dart';
import 'package:cabavenue_drive/services/notification_service.dart';
import 'package:cabavenue_drive/services/ride_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moment_dart/moment_dart.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({Key? key}) : super(key: key);

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  late Future<List<RideModel>> requests;

  Future<List<RideModel>> getRides(BuildContext context) async {
    var rides = await RideService().getRides(context);
    List<RideModel> reqs = [];
    for (var ride in rides) {
      reqs.add(await RideModel.deserialize(jsonEncode(ride).toString()));
    }
    return reqs;
  }

  @override
  void initState() {
    super.initState();
    requests = getRides(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child:
                  Text('Today', style: Theme.of(context).textTheme.headline1),
            ),
            FutureBuilder<List<RideModel>>(
              future: requests,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
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
                        itemCount: snapshot.data!.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          padding: EdgeInsets.only(right: 6.0),
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
                                              child: Flexible(
                                                child: Text(snapshot
                                                    .data![index]
                                                    .source['name']),
                                              ),
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
                                          padding: EdgeInsets.only(right: 6.0),
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
                                              child: Flexible(
                                                child: Text(snapshot
                                                    .data![index]
                                                    .destination['name']),
                                              ),
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
                                      Moment(DateTime.parse(
                                              snapshot.data![index].createdAt))
                                          .fromNow(form: UnitStringForm.short),
                                    ),
                                    Text(
                                      "Rs. ${snapshot.data![index].price.toString()}",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          iconSize: 50.0,
                                          color: Colors.teal,
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                snapshot.data![index],
                                                "confirm");
                                          },
                                          icon: const Icon(Iconsax.tick_circle),
                                        ),
                                        IconButton(
                                          iconSize: 50.0,
                                          color: Colors.redAccent,
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                snapshot.data![index],
                                                "reject");
                                          },
                                          icon:
                                              const Icon(Iconsax.close_circle),
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
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// show alert dialouge for confirmation of request rides
showAlertDialog(BuildContext context, RideModel request, type) {
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
      } else {
        RideService().rejectRequest(context, request.id);
        NotificationService().sendRideRequestNotification(
          context,
          request.passenger,
          "Request Cancelled",
          "Your Request has been cancelled",
        );
      }
      Navigator.of(context).pop();
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
      return alert;
    },
  );
}
