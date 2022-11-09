import 'package:flutter/cupertino.dart';

class DisableProvider with ChangeNotifier {
  bool isDisabled = false;

  bool get getIsDisabled => isDisabled;

  void setIsDisabled(bool newIsDisabled) {
    isDisabled = newIsDisabled;
    notifyListeners();
  }
}
