import 'dart:convert';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AreaServices {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];

  dynamic getAreas(BuildContext context) async {
    try {
      List area = await http.get(
        Uri.parse('http://$url/v1/areas'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return [];
        }
      });

      return area;
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
