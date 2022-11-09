import 'dart:convert';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReportService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  void report(
      BuildContext context, String name, String id, String reportDes) async {
    try {
      var report = {
        'userId': id,
        'userType': 'user',
        'userName': name,
        'report': reportDes,
      };

      String token = await _tokenService.getToken();

      await http.post(
        Uri.parse('http://$url/v1/reports'),
        body: jsonEncode(report),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode != 201) {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
