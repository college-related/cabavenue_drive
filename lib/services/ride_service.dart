import 'dart:convert';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RideService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic getRides(BuildContext context) async {
    String token = await _tokenService.getToken();
    String id = await _tokenService.getUserId();

    try {
      var places = await http.get(
        Uri.parse('http://$url/v1/rides/my/$id'),
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

      return places;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return [];
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
          return [];
        }
      });

      return places;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return [];
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
        Fluttertoast.showToast(msg: 'Rejected ride');
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }
}
