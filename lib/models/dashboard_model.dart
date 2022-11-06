import 'dart:convert';

class DashboardModel {
  int totalRides;
  double totalEarnings;
  int totalRating;
  dynamic totalsToday;

  DashboardModel({
    required this.totalRides,
    required this.totalEarnings,
    required this.totalRating,
    required this.totalsToday,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> jsonData) {
    return DashboardModel(
      totalRides: jsonData['totalRides'],
      totalEarnings: jsonData['totalEarnings'],
      totalRating: jsonData['totalRating'],
      totalsToday: jsonData['totalsToday'],
    );
  }

  static Map<String, dynamic> toMap(DashboardModel model) => {
        'totalRides': model.totalRides,
        'totalEarnings': model.totalEarnings,
        'totalRating': model.totalRating,
        'totalsToday': model.totalsToday,
      };

  static String serialize(DashboardModel model) =>
      json.encode(DashboardModel.toMap(model));

  static Future<DashboardModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 2),
      () => DashboardModel.fromJson(jsonDecode(json)));

  static DashboardModel deserializeFast(String json) =>
      DashboardModel.fromJson(jsonDecode(json));
}
