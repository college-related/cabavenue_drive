// ignore_for_file: use_build_context_synchronously
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:cabavenue_drive/services/notification_service.dart';
import 'package:cabavenue_drive/services/ride_service.dart';
import 'package:cabavenue_drive/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CurrentRideScreen extends StatefulWidget {
  const CurrentRideScreen({Key? key}) : super(key: key);

  @override
  State<CurrentRideScreen> createState() => _CurrentRideScreenState();
}

class _CurrentRideScreenState extends State<CurrentRideScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> completeRide(
      BuildContext context, String id, String userId) async {
    await RideService().completeRide(context, id);
    await NotificationService().sendRideRequestNotification(
        context, userId, "Ride Completed", "Your ride is completed");
  }

  Future<void> updateRideHistory() async {
    var rideHistory = await RideService().getRideHistory(context);
    UserService().setRideHistory(rideHistory);
    Provider.of<ProfileProvider>(context, listen: false)
        .setRideHistory(rideHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
      child: Consumer<RideRequestProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(
              child: value.getRideRequestListData.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Source: ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Expanded(
                              child: Text(
                                value
                                    .getRideRequestListData[
                                        value.rideIndex ?? 0]
                                    .source["name"],
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Destination: ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Expanded(
                              child: Text(
                                value
                                    .getRideRequestListData[
                                        value.rideIndex ?? 0]
                                    .destination["name"],
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Price: ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Rs. ${num.parse(value.getRideRequestListData[value.rideIndex ?? 0].price.toString()).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15.0,
                            ),
                          ),
                          onPressed: () {
                            completeRide(
                              context,
                              value
                                  .getRideRequestListData[
                                      value.getRideIndex ?? 0]
                                  .id,
                              value
                                  .getRideRequestListData[
                                      value.getRideIndex ?? 0]
                                  .passenger,
                            ).then((val) {
                              updateRideHistory().then((va) {
                                Provider.of<RideRequestProvider>(context,
                                        listen: false)
                                    .removeRideRequestFromList(
                                        value.getRideIndex ?? 0);
                                Provider.of<ProfileProvider>(context,
                                        listen: false)
                                    .setInRide(false);
                                UserService().setInRide(false);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home', (route) => false);
                              });
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Iconsax.fatrows),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Complete Ride'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
