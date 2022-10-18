import 'dart:convert';

class AreaModel {
  dynamic areas;

  AreaModel({
    required this.areas,
  });

  factory AreaModel.fromJson(Map<String, dynamic> jsonData) {
    return AreaModel(
      areas: jsonData['areas'],
    );
  }

  static Map<String, dynamic> toMap(AreaModel model) => {
        'areas': model.areas,
      };

  static String serialize(AreaModel model) =>
      json.encode(AreaModel.toMap(model));

  static Future<AreaModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 2), () => AreaModel.fromJson(jsonDecode(json)));

  static AreaModel deserializeFast(String json) =>
      AreaModel.fromJson(jsonDecode(json));
}
