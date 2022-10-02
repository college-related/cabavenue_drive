import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({Key? key}) : super(key: key);

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final bool _hasRideRequests = Random().nextBool();
  final List _requests = [
    {
      "pickup": "Lamachour",
      "destination": "Mahendrapool",
      "price": "300",
      "request-time": "3:00 PM",
    },
    {
      "pickup": "Lamachour",
      "destination": "Nayabazzar",
      "price": "400",
      "request-time": "3:20 PM",
    },
  ];

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
              : RideRequestCard(requests: _requests),
        ],
      ),
    );
  }
}

class RideRequestCard extends StatefulWidget {
  const RideRequestCard({
    Key? key,
    required this.requests,
  }) : super(key: key);

  final List requests;

  @override
  State<RideRequestCard> createState() => _RideRequestCardState();
}

class _RideRequestCardState extends State<RideRequestCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100.0),
        itemCount: widget.requests.length,
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
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Icon(Iconsax.location, size: 20.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup point',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(widget.requests[index]['pickup']),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Icon(Iconsax.location, size: 20.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destination',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(widget.requests[index]['destination']),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.requests[index]['request-time']),
                    Text(
                      "Rs. ${widget.requests[index]['price']}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 50.0,
                          color: Colors.teal,
                          onPressed: () {
                            showAlertDialog(
                                context, widget.requests[index], "confirm");
                          },
                          icon: const Icon(Iconsax.tick_circle),
                        ),
                        IconButton(
                          iconSize: 50.0,
                          color: Colors.redAccent,
                          onPressed: () {
                            showAlertDialog(
                                context, widget.requests[index], "reject");
                          },
                          icon: const Icon(Iconsax.close_circle),
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

// show alert dialouge for confirmation of request rides
showAlertDialog(BuildContext context, request, type) {
  // Create yes button
  Widget yesButton = ElevatedButton(
    onPressed: () {
      // ignore: todo
      // TODO: Handle accept or reject of ride
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
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(Iconsax.location, size: 20.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup point',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(request['pickup']),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(Iconsax.location, size: 20.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Destination',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(request['destination']),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(request['request-time']),
                Text(
                  "Rs. ${request['price']}",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ],
        ),
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
