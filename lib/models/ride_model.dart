import 'dart:convert';

class RideModel {
  dynamic source;
  dynamic destination;
  int price;
  String driver;
  String passenger;
  String id;
  String createdAt;

  RideModel({
    required this.source,
    required this.destination,
    required this.price,
    required this.driver,
    required this.passenger,
    required this.createdAt,
    required this.id,
  });

  factory RideModel.fromJson(Map<String, dynamic> jsonData) {
    return RideModel(
      source: jsonData['source'],
      destination: jsonData['destination'],
      price: jsonData['price'],
      driver: jsonData['driver'],
      passenger: jsonData['passenger'],
      createdAt: jsonData['createdAt'],
      id: jsonData['_id'],
    );
  }

  static Map<String, dynamic> toMap(RideModel model) => {
        'source': model.source,
        'destination': model.destination,
        'price': model.price,
        'driver': model.driver,
        'passenger': model.passenger,
        'createdAt': model.createdAt,
        'id': model.id,
      };

  static String serialize(RideModel model) =>
      json.encode(RideModel.toMap(model));

  static Future<RideModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 2), () => RideModel.fromJson(jsonDecode(json)));

  static RideModel deserializeFast(String json) =>
      RideModel.fromJson(jsonDecode(json));
}
