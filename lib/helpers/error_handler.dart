import 'dart:convert';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/providers/device_provider.dart';
import 'package:cabavenue_drive/providers/disable_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      if (jsonDecode(response.body)['message'] == 'User is disabled') {
        Fluttertoast.showToast(
          msg: 'Your account has been disbaled',
          backgroundColor: Colors.red[500],
        );
        Provider.of<DisableProvider>(context, listen: false)
            .setIsDisabled(true);
      } else {
        showSnackBar(context, jsonDecode(response.body)['message'], true);
      }
      if (ModalRoute.of(context)!.settings.name != '/auth') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/auth', (route) => false);
        Provider.of<DeviceProvider>(context, listen: false)
            .deleteDevice(context);
        Future.delayed(
          const Duration(seconds: 3),
          () => const FlutterSecureStorage().delete(key: "CABAVENUE_USERDATA"),
        );
      }
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'], true);
      break;
    default:
      showSnackBar(context, response.body, true);
  }
}
