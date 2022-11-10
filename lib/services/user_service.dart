import 'dart:convert';

import 'package:cabavenue_drive/helpers/error_handler.dart';
import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/models/user_model.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  void editProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String plateNumber,
    required String model,
    required String color,
    required bool provideEmergencyService,
    required BuildContext context,
  }) async {
    try {
      String id = await _tokenService.getUserId();
      String token = await _tokenService.getToken();

      var user = {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'vehicleData': {
          'plateNumber': plateNumber,
          'color': color,
          'model': model,
        },
        'provideEmergencyService': provideEmergencyService,
      };

      var profile = await http.patch(
        Uri.parse('http://$url/v1/users/$id'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      if (profile != null) {
        String token = await TokenService().getToken();

        UserModel newUser = UserModel(
          role: jsonDecode(profile.body)["role"],
          name: jsonDecode(profile.body)["name"],
          isEmailVerified: jsonDecode(profile.body)["isEmailVerified"],
          isPhoneVerified: jsonDecode(profile.body)["isPhoneVerified"],
          email: jsonDecode(profile.body)["email"],
          phone: jsonDecode(profile.body)["phone"],
          address: jsonDecode(profile.body)["address"],
          accessToken: token,
          vehicleData: jsonDecode(profile.body)["vehicleData"],
          id: jsonDecode(profile.body)["id"],
          area: jsonDecode(profile.body)["area"],
          documents: jsonDecode(profile.body)["documents"],
          profileUrl: jsonDecode(profile.body)["profileUrl"],
          isInRide: jsonDecode(profile.body)["isInRide"],
          provideEmergencyService:
              jsonDecode(profile.body)["provideEmergencyService"],
        );

        const FlutterSecureStorage().write(
          key: "CABAVENUE_USERDATA",
          value: UserModel.serialize(newUser),
        );
        // ignore: use_build_context_synchronously
        Provider.of<ProfileProvider>(context, listen: false)
            .setUserData(newUser);

        Fluttertoast.showToast(
          msg: 'Profile Edited successfully',
          backgroundColor: Colors.lightGreen[300],
          textColor: Colors.black87,
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void updateDocument({
    required String profileUrl,
    required List documents,
    required BuildContext context,
  }) async {
    try {
      String id = await _tokenService.getUserId();
      String token = await _tokenService.getToken();

      var user = {
        'profileUrl': profileUrl,
        'documents': documents,
      };

      var profile = await http.patch(
        Uri.parse('http://$url/v1/users/$id'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      if (profile != null) {
        String token = await TokenService().getToken();

        UserModel newUser = UserModel(
          role: jsonDecode(profile.body)["role"],
          name: jsonDecode(profile.body)["name"],
          isEmailVerified: jsonDecode(profile.body)["isEmailVerified"],
          isPhoneVerified: jsonDecode(profile.body)["isPhoneVerified"],
          email: jsonDecode(profile.body)["email"],
          phone: jsonDecode(profile.body)["phone"],
          address: jsonDecode(profile.body)["address"],
          accessToken: token,
          vehicleData: jsonDecode(profile.body)["vehicleData"],
          id: jsonDecode(profile.body)["id"],
          area: jsonDecode(profile.body)["area"],
          documents: jsonDecode(profile.body)["documents"],
          profileUrl: jsonDecode(profile.body)["profileUrl"],
          isInRide: jsonDecode(profile.body)["isInRide"],
          provideEmergencyService:
              jsonDecode(profile.body)["provideEmergencyService"],
        );

        const FlutterSecureStorage().write(
          key: "CABAVENUE_USERDATA",
          value: UserModel.serialize(newUser),
        );
        // ignore: use_build_context_synchronously
        Provider.of<ProfileProvider>(context, listen: false)
            .setUserData(newUser);

        Fluttertoast.showToast(
          msg: 'Document Edited successfully',
          backgroundColor: Colors.lightGreen[300],
          textColor: Colors.black87,
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  Future<void> setInRide(bool inRide) async {
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    var u = await flutterSecureStorage.read(key: "CABAVENUE_USERDATA");

    var user = UserModel.deserializeFast(u ?? '{}');

    user.isInRide = inRide;

    await flutterSecureStorage.write(
        key: "CABAVENUE_USERDATA", value: UserModel.serialize(user));
  }

  Future<void> setRideHistory(rideHistory) async {
    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    var u = await flutterSecureStorage.read(key: "CABAVENUE_USERDATA");

    var user = UserModel.deserializeFast(u ?? '{}');

    user.rideHistory = rideHistory;

    await flutterSecureStorage.write(
        key: "CABAVENUE_USERDATA", value: UserModel.serialize(user));
  }
}
