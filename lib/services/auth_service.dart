import 'dart:convert';
import 'dart:io';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/models/user_model.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    required String areaId,
    required String areaName,
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
        'area': {
          'id': areaId,
          'name': areaName,
        },
      };

      await http.post(
        Uri.parse('http://$url/v1/auth/register'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((res) async {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            UserModel user = UserModel(
              role: jsonDecode(res.body)["user"]["role"],
              name: jsonDecode(res.body)["user"]["name"],
              isEmailVerified: jsonDecode(res.body)["user"]["isEmailVerified"],
              isPhoneVerified: jsonDecode(res.body)["user"]["isPhoneVerified"],
              email: jsonDecode(res.body)["user"]["email"],
              phone: jsonDecode(res.body)["user"]["phone"],
              address: jsonDecode(res.body)["user"]["address"],
              accessToken: jsonDecode(res.body)["tokens"]["access"]["token"],
              vehicleData: jsonDecode(res.body)["user"]["vehicleData"],
              id: jsonDecode(res.body)["user"]["id"],
              area: jsonDecode(res.body)["user"]["area"],
            );
            const FlutterSecureStorage().write(
              key: "CABAVENUE_USERDATA",
              value: UserModel.serialize(user),
            );
            Provider.of<ProfileProvider>(context, listen: false)
                .setUserData(user);
            Fluttertoast.showToast(
              msg: 'Registered successfully',
              backgroundColor: Colors.green,
            );
          },
        );

        if (jsonDecode(res.body)['user']['id'] != null) {
          var id = jsonDecode(res.body)['user']['id'];
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

          httpErrorHandle(
            response: response as http.Response,
            context: context,
            onSuccess: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
          );
        }
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
          UserModel user = UserModel(
            role: jsonDecode(res.body)["user"]["role"],
            name: jsonDecode(res.body)["user"]["name"],
            isEmailVerified: jsonDecode(res.body)["user"]["isEmailVerified"],
            isPhoneVerified: jsonDecode(res.body)["user"]["isPhoneVerified"],
            email: jsonDecode(res.body)["user"]["email"],
            phone: jsonDecode(res.body)["user"]["phone"],
            address: jsonDecode(res.body)["user"]["address"],
            accessToken: jsonDecode(res.body)["tokens"]["access"]["token"],
            vehicleData: jsonDecode(res.body)["user"]["vehicleData"],
            id: jsonDecode(res.body)["user"]["id"],
            area: jsonDecode(res.body)["user"]["area"],
          );
          const FlutterSecureStorage().write(
            key: "CABAVENUE_USERDATA",
            value: UserModel.serialize(user),
          );
          Provider.of<ProfileProvider>(context, listen: false)
              .setUserData(user);
          Fluttertoast.showToast(msg: 'Logged in successfully');
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
