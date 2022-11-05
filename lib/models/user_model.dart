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
  dynamic area;
  List documents;
  String profileUrl;
  bool isInRide;
  List? rideHistory = [];

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
    required this.area,
    required this.documents,
    required this.profileUrl,
    required this.isInRide,
    this.rideHistory,
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
      area: jsonData['area'],
      documents: jsonData['documents'],
      profileUrl: jsonData['profileUrl'],
      rideHistory: jsonData['rideHistory'],
      isInRide: jsonData['isInRide'],
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
        'area': model.area,
        'documents': model.documents,
        'profileUrl': model.profileUrl,
        'rideHistory': model.rideHistory,
        'isInRide': model.isInRide,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static Future<UserModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1), () => UserModel.fromJson(jsonDecode(json)));

  static UserModel deserializeFast(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
