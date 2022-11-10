// ignore_for_file: use_build_context_synchronously

import 'package:cabavenue_drive/models/device_model.dart';
import 'package:cabavenue_drive/services/device_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class DeviceProvider with ChangeNotifier {
  DeviceModel? device;

  get getDevice => device;

  DeviceProvider(BuildContext context) {
    init(context);
  }

  void init(BuildContext context) async {
    await initFirebaseApp(context);
  }

  void update(BuildContext context, String userId, String accessToken) async {
    DeviceService deviceService = DeviceService();
    if (device != null) {
      var fromServer = await deviceService.updateDevice(
        context,
        device!.id,
        userId,
        accessToken,
      );
      device = await DeviceModel.deserialize(fromServer.toString());
    }

    notifyListeners();
  }

  void deleteDevice(BuildContext context) async {
    DeviceService deviceService = DeviceService();
    if (device != null) {
      deviceService.deleteDevice(context, device!.firebaseToken);
    }
    notifyListeners();
  }

  void setDevice(DeviceModel newDevice) {
    device = newDevice;
    notifyListeners();
  }

  Future<void> initFirebaseApp(BuildContext context) async {
    // await Firebase.initializeApp();
    DeviceService deviceService = DeviceService();
    var firebaseToken = (await FirebaseMessaging.instance.getToken()) ?? "";
    var fromServer =
        await deviceService.fetchByFirebaseToken(context, firebaseToken);
    if (fromServer != null) {
      device = DeviceModel.deserializeFast(fromServer!.toString());
    } else {
      device = await DeviceModel.deserialize(
        deviceService.createNew(context, firebaseToken).toString(),
      );
    }
    notifyListeners();
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
