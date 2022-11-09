// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class RideService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  String? api = dotenv.env['PLACES_API_GEOAPIFY'];
  final TokenService _tokenService = TokenService();

  dynamic getRides(BuildContext context, String? filter) async {
    String token = await _tokenService.getToken();
    String id = await _tokenService.getUserId();

    try {
      var rides = await http.get(
        Uri.parse('http://$url/v1/rides/my/$id?filter=$filter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return rides;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return null;
    }
  }

  dynamic acceptRequest(
    BuildContext context,
    String id,
  ) async {
    String token = await _tokenService.getToken();

    try {
      var places = await http.patch(
        Uri.parse('http://$url/v1/rides/$id'),
        body: jsonEncode({"status": "accepted"}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return places;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return null;
    }
  }

  void rejectRequest(
    BuildContext context,
    String id,
  ) async {
    String token = await _tokenService.getToken();

    try {
      await http.delete(
        Uri.parse('http://$url/v1/rides/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode != 204) {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        } else {
          Fluttertoast.showToast(msg: 'Rejected ride');
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }

  dynamic completeRide(
    BuildContext context,
    String id,
  ) async {
    String token = await _tokenService.getToken();

    try {
      var rides = await http.patch(
        Uri.parse('http://$url/v1/rides/$id'),
        body: jsonEncode({"status": "completed"}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return rides;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return null;
    }
  }

  dynamic getRideHistory(BuildContext context) async {
    String token = await _tokenService.getToken();
    String id = await _tokenService.getUserId();

    try {
      var rideHistories = await http.get(
        Uri.parse('http://$url/v1/users/history/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return [];
        }
      });

      return rideHistories;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return [];
    }
  }

  Future<List<LatLng>> getRoutingPolyPoint(
    BuildContext context,
    startLat,
    startLng,
    desLat,
    desLng,
  ) async {
    List<LatLng> polys = [];
    try {
      await http
          .get(
        Uri.parse(
            'https://api.geoapify.com/v1/routing?waypoints=$startLat,$startLng|$desLat,$desLng&mode=drive&apiKey=$api'),
      )
          .then((value) {
        if (value.statusCode == 200) {
          var latlngs = jsonDecode(value.body)["features"][0]["geometry"]
              ["coordinates"][0];

          for (var element in latlngs) {
            polys.add(LatLng(element[1], element[0]));
          }
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
    return polys;
  }
}
