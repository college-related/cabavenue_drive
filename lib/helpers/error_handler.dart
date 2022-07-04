import 'dart:convert';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message'], true);
      break;
    case 401:
      showSnackBar(context, jsonDecode(response.body)['message'], true);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'], true);
      break;
    default:
      showSnackBar(context, response.body, true);
  }
}