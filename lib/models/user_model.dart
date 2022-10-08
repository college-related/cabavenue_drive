import 'dart:convert';

class UserModel {
  String role;
  String name;
  bool isEmailVerified;
  bool isPhoneVerified;
  String email;
  int phone;
  String address;
  String id;
  String accessToken;
  dynamic vehicleData;

  UserModel({
    required this.name,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.email,
    required this.phone,
    required this.address,
    required this.accessToken,
    required this.vehicleData,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['name'],
      role: jsonData['role'],
      isEmailVerified: jsonData['isEmailVerified'],
      isPhoneVerified: jsonData['isPhoneVerified'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      address: jsonData['address'],
      accessToken: jsonData['accessToken'],
      vehicleData: jsonData['vehicleData'],
      id: jsonData['id'],
    );
  }

  static Map<String, dynamic> toMap(UserModel model) => {
        'role': model.role,
        'isEmailVerified': model.isEmailVerified,
        'isPhoneVerified': model.isPhoneVerified,
        'email': model.email,
        'phone': model.phone,
        'address': model.address,
        'accessToken': model.accessToken,
        'vehicleData': model.vehicleData,
        'id': model.id,
        'name': model.name,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static Future<UserModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1), () => UserModel.fromJson(jsonDecode(json)));

  static UserModel deserializeFast(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
