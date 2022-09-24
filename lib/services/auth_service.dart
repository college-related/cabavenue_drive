import 'dart:convert';
import 'dart:io';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];

  void signupDriver({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String plateNumber,
    required String color,
    required String model,
    required XFile? citizenship,
    required XFile? license,
    required XFile? bluebook,
    required BuildContext context,
  }) async {
    try {
      var user = {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
        'vehicleData': {
          'plateNumber': plateNumber,
          'color': color,
          'model': model,
        },
        'role': 'driver',
      };

      await http.post(
        Uri.parse('http://$url/v1/auth/register'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) async {
        httpErrorHandle(
          response: value,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Registered successfully', false);
          },
        );

        if (jsonDecode(value.body)['user']['id'] != null) {
          const FlutterSecureStorage().write(
              key: "CABAVENUE_USERDATA",
              value: jsonDecode(value.body).toString());

          var id = jsonDecode(value.body)['user']['id'];
          var request = http.MultipartRequest(
              "POST", Uri.parse('http://$url/v1/documents/upload/$id'));

          List<http.MultipartFile> imageList = [];

          http.MultipartFile citizenshipMultipart = http.MultipartFile(
              'documents',
              File(citizenship!.path).readAsBytes().asStream(),
              File(citizenship.path).lengthSync(),
              filename: citizenship.path.split("/").last);
          imageList.add(citizenshipMultipart);

          http.MultipartFile licenseMultipart = http.MultipartFile(
              'documents',
              File(license!.path).readAsBytes().asStream(),
              File(license.path).lengthSync(),
              filename: license.path.split("/").last);
          imageList.add(licenseMultipart);

          http.MultipartFile bluebookMultipart = http.MultipartFile(
              'documents',
              File(bluebook!.path).readAsBytes().asStream(),
              File(bluebook.path).lengthSync(),
              filename: bluebook.path.split("/").last);
          imageList.add(bluebookMultipart);

          request.files.addAll(imageList);
          var response = await request.send();

          if (response.statusCode == 200) {
            // const FlutterSecureStorage().write(key: "CABAVENUE_USER_DOCUMENTS", value: jsonDecode(response.stream))
            Navigator.of(context).pushNamed('/home');
          }

          showSnackBar(context, response.toString(), false);
        }
        // httpErrorHandle(
        //   response: response as http.Response,
        //   context: context,
        //   onSuccess: () {
        //     Navigator.of(context).pushNamed('/');
        //   },
        // );
      });
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void loginDriver({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    try {
      var user = {
        'phone': phone,
        'password': password,
      };

      http.Response res = await http.post(
        Uri.parse('http://$url/v1/auth/login'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          const FlutterSecureStorage().write(
              key: "CABAVENUE_USERDATA",
              value: jsonDecode(res.body).toString());
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void logout(context) async {
    const FlutterSecureStorage().delete(key: "CABAVENUE_USERDATA");
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
