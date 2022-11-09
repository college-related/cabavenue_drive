// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cabavenue_drive/providers/ride_request_provider.dart';
import 'package:cabavenue_drive/services/ride_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RideModel {
  dynamic source;
  dynamic destination;
  double price;
  String driver;
  String passenger;
  String id;
  String createdAt;
  String status;

  RideModel({
    required this.source,
    required this.destination,
    required this.price,
    required this.driver,
    required this.passenger,
    required this.createdAt,
    required this.id,
    required this.status,
  });

  factory RideModel.fromJson(Map<String, dynamic> jsonData) {
    return RideModel(
      source: jsonData['source'],
      destination: jsonData['destination'],
      price: jsonData['price'],
      driver: jsonData['driver'],
      passenger: jsonData['passenger'],
      createdAt: jsonData['createdAt'],
      id: jsonData['_id'],
      status: jsonData['status'],
    );
  }

  static Map<String, dynamic> toMap(RideModel model) => {
        'source': model.source,
        'destination': model.destination,
        'price': model.price,
        'driver': model.driver,
        'passenger': model.passenger,
        'createdAt': model.createdAt,
        'id': model.id,
        'status': model.status,
      };

  static String serialize(RideModel model) =>
      json.encode(RideModel.toMap(model));

  static Future<RideModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 2), () => RideModel.fromJson(jsonDecode(json)));

  static RideModel deserializeFast(String json) =>
      RideModel.fromJson(jsonDecode(json));

  static Future<List<RideModel>> getRides(
      BuildContext context, String filter) async {
    var rides = await RideService().getRides(context, filter);
    List<RideModel> reqs = [];
    if (rides != null) {
      for (var ride in rides) {
        reqs.add(await RideModel.deserialize(jsonEncode(ride).toString()));
      }
      return reqs;
    }

    return Future.delayed(const Duration(seconds: 1), () => reqs);
  }

  static Future<void> getRequestRides(BuildContext context,
      {String filter = "all"}) async {
    List<RideModel> requests = await getRides(context, filter);
    Provider.of<RideRequestProvider>(context, listen: false)
        .setRideRequestListData(requests);
    Provider.of<RideRequestProvider>(context, listen: false)
        .setIsFetching(false);
  }
}
