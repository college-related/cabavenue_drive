import 'package:cabavenue_drive/models/ride_model.dart';
import 'package:flutter/cupertino.dart';

class RideRequestProvider with ChangeNotifier {
  List<RideModel>? rideRequestList;
  bool isFetching = true;
  int? rideIndex;

  List<RideModel> get getRideRequestListData => rideRequestList ?? [];
  bool get getIsRideRequestFetching => isFetching;
  int? get getRideIndex => rideIndex;

  void setRideRequestListData(List<RideModel> newRideRequestList) {
    rideRequestList = newRideRequestList;
    notifyListeners();
  }

  void removeRideRequestFromList(int index) {
    rideRequestList!.removeAt(index);
    notifyListeners();
  }

  void setIsFetching(bool newIsFetching) {
    isFetching = newIsFetching;
    notifyListeners();
  }

  void setRideIndex(int index) {
    rideIndex = index;
    notifyListeners();
  }
}
