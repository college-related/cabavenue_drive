import 'package:cabavenue_drive/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  UserModel user = UserModel(
    name: '',
    role: 'Driver',
    isEmailVerified: false,
    isPhoneVerified: false,
    email: '',
    phone: 0,
    address: '',
    accessToken: '',
    vehicleData: {
      'model': '',
      'color': '',
      'plateNumber': '',
    },
    id: '',
    area: {
      'id': '',
      'name': '',
    },
    documents: [],
    profileUrl:
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
    rideHistory: [],
  );

  UserModel get getUserData => user;

  void setUserData(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}
